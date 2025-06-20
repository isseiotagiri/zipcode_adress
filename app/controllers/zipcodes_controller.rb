class ZipcodesController < ApplicationController
  require 'httparty'
  require 'csv'
  require 'tempfile'
  
  def index
    # トップページを表示するアクション
  end

  def search
    # 郵便番号から住所を検索するアクション
    @zipcode = params[:zipcode]
    
    # ハイフンを削除
    @zipcode = @zipcode.gsub('-', '') if @zipcode.present?
    
    if @zipcode.present? && @zipcode.match(/^\d{7}$/)
      # APIリクエストを送信
      response = HTTParty.get("https://zipcloud.ibsnet.co.jp/api/search?zipcode=#{@zipcode}")
      
      if response.code == 200
        result = JSON.parse(response.body)
        
        if result["status"] == 200
          @address_data = result["results"]
        else
          @error = result["message"] || "住所の取得に失敗しました。"
        end
      else
        @error = "APIリクエストに失敗しました。"
      end
    elsif @zipcode.present?
      @error = "郵便番号は7桁の数字で入力してください。"
    end
    
    render :index
  end

  def send_sms
    @phone_number = params[:phone_number]
    @text_message = params[:text_message]
    
    # バリデーション
    if @phone_number.blank? || @text_message.blank?
      @sms_error = "携帯番号とメッセージを入力してください。"
      render :index
      return
    end
    
    # 携帯番号の形式チェック（090、080、070で始まる11桁）
    phone_formatted = @phone_number.gsub(/[-\s]/, '')
    unless phone_formatted.match(/^(090|080|070)\d{8}$/)
      @sms_error = "携帯番号の形式が正しくありません。（例: 090-1234-5678）"
      render :index
      return
    end
    
    # SMS API呼び出し
    begin
      api_token = Rails.application.credentials.sms_api_token || ENV['SMS_API_TOKEN']
      
      if api_token.blank?
        @sms_error = "SMS API設定が正しくありません。管理者にお問い合わせください。"
        render :index
        return
      end
      
      headers = {
        'Accept' => 'application/json',
        'token' => api_token,
        'Content-Type' => 'application/json'
      }
      
      body = {
        contacts: [
          {
            phone_number: phone_formatted
          }
        ],
        text_message: @text_message
      }.to_json
      
      response = HTTParty.post(
        'https://sand-api-smslink.nexlink2.jp/api/v1/delivery',
        headers: headers,
        body: body
      )
      
      if response.code == 200 || response.code == 201
        @sms_success = "SMSを送信しました。"
        # フォームをクリア
        @phone_number = nil
        @text_message = nil
      else
        result = JSON.parse(response.body) rescue {}
        error_message = result["message"] || result["error"] || "SMS送信に失敗しました。"
        @sms_error = "SMS送信エラー: #{error_message}"
      end
      
    rescue => e
      @sms_error = "SMS送信に失敗しました: #{e.message}"
    end
    
    render :index
  end

  def send_fax
    @fax_number = params[:fax_number]
    @contacts_file = params[:contacts_file]
    @document_file = params[:document_file]
    
    # バリデーション
    if @fax_number.blank? && @contacts_file.blank?
      @fax_error = "FAX番号を入力するか、宛先ファイルをアップロードしてください。"
      render :index
      return
    end
    
    if @document_file.blank?
      @fax_error = "FAX原稿をアップロードしてください。"
      render :index
      return
    end
    
    # FAX番号の形式チェック（FAX番号が入力されている場合）
    if @fax_number.present?
      fax_formatted = @fax_number.gsub(/[-\s]/, '')
      unless fax_formatted.match(/^\d{9,11}$/)
        @fax_error = "FAX番号の形式が正しくありません。（例: 03-1234-5678）"
        render :index
        return
      end
    end
    
    # FAX API呼び出し
    begin
      api_token = Rails.application.credentials.fax_api_token || ENV['FAX_API_TOKEN']
      
      if api_token.blank?
        @fax_error = "FAX API設定が正しくありません。管理者にお問い合わせください。"
        render :index
        return
      end
      
      # Step 1: 宛先リスト作成
      contact_list_id = create_contact_list(api_token)
      return if contact_list_id.nil?
      
      # Step 2: FAX新規作成
      facsimile_id = create_facsimile(api_token, contact_list_id)
      return if facsimile_id.nil?
      
      # Step 3: FAX原稿登録
      unless upload_fax_content(api_token, facsimile_id)
        return
      end
      
      # Step 4: FAX送信
      if send_fax_transmission(api_token, facsimile_id)
        @fax_success = "FAXを送信しました。"
        # フォームをクリア
        @fax_number = nil
        @contacts_file = nil
        @document_file = nil
      end
      
    rescue => e
      Rails.logger.error "FAX送信に失敗しました: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      @fax_error = "FAX送信に失敗しました: #{e.message}"
    end
    
    render :index
  end
  
  private
  
  def create_contact_list(api_token)
    # CSVファイルの作成
    csv_data = ""
    
    if @fax_number.present?
      # 単一のFAX番号からCSVを作成
      fax_formatted = @fax_number.gsub(/[-\s]/, '')
      csv_data = CSV.generate do |csv|
        csv << ["FAX番号"]  # ヘッダー行
        csv << [fax_formatted]
      end
    elsif @contacts_file.present?
      # アップロードされたファイルを使用
      csv_data = @contacts_file.read
    end
    
    # 一時ファイルを作成
    temp_file = Tempfile.new(['contacts', '.csv'])
    temp_file.write(csv_data)
    temp_file.rewind
    
    headers = {
      'Accept' => 'application/json',
      'Authorization' => "token #{api_token}"
    }
    
    response = HTTParty.post(
      'https://sandbox-hea.nexlink2.jp/api/v1/contact_lists',
      headers: headers,
      body: {
        name: "FAX宛先リスト_#{Time.current.strftime('%Y%m%d_%H%M%S')}",
        mapping_columns: { "fax": 0 }.to_json,
        file: File.open(temp_file.path, 'r')
      }
    )
    
    temp_file.close
    temp_file.unlink
    
    if response.code == 200 || response.code == 201
      result = JSON.parse(response.body)
      result["contact_list_id"]
    else
      result = JSON.parse(response.body) rescue {}
      error_message = result["message"] || result["error"] || "宛先リスト作成に失敗しました。"
      @fax_error = "宛先リスト作成エラー: #{error_message}"
      nil
    end
  end
  
  def create_facsimile(api_token, contact_list_id)
    headers = {
      'Accept' => 'application/json',
      'Authorization' => "token #{api_token}",
      'Content-Type' => 'application/json'
    }
    
    body = {
      delivery_name: "FAX配信_#{Time.current.strftime('%Y%m%d_%H%M%S')}",
      contact_list_id: contact_list_id,
      use_print_header: false,
      fax_quality: 0,
      fax_speed: 1,
      allow_international_fax: false,
      allow_duplicate_fax_numbers: false
    }.to_json
    
    response = HTTParty.post(
      'https://sandbox-hea.nexlink2.jp/api/v1/facsimiles',
      headers: headers,
      body: body
    )
    
    if response.code == 200 || response.code == 201
      result = JSON.parse(response.body)
      result["facsimile_id"]
    else
      result = JSON.parse(response.body) rescue {}
      error_message = result["message"] || result["error"] || "FAX作成に失敗しました。"
      @fax_error = "FAX作成エラー: #{error_message}"
      nil
    end
  end
  
  def upload_fax_content(api_token, facsimile_id)
    # ファイルタイプの判定
    file_extension = File.extname(@document_file.original_filename).downcase
    content_type = case file_extension
    when '.pdf'
      'application/pdf'
    when '.doc'
      'application/msword'
    when '.docx'
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
    when '.xls'
      'application/vnd.ms-excel'
    when '.xlsx'
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    when '.ppt'
      'application/vnd.ms-powerpoint'
    when '.pptx'
      'application/vnd.openxmlformats-officedocument.presentationml.presentation'
    else
      @fax_error = "サポートされていないファイル形式です。PDF、Word、Excel、PowerPointファイルのみアップロード可能です。"
      return false
    end
    
    # 一時ファイルとして保存
    temp_file = Tempfile.new(['fax_content', file_extension])
    temp_file.binmode
    temp_file.write(@document_file.read)
    temp_file.rewind
    
    headers = {
      'Accept' => 'application/json',
      'Authorization' => "token #{api_token}"
    }
    
    response = HTTParty.post(
      "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/#{facsimile_id}/contents",
      headers: headers,
      body: {
        file: File.open(temp_file.path, 'rb')
      }
    )
    
    temp_file.close
    temp_file.unlink
    
    if response.code == 200 || response.code == 201
      true
    else
      result = JSON.parse(response.body) rescue {}
      error_message = result["message"] || result["error"] || "FAX原稿アップロードに失敗しました。"
      @fax_error = "FAX原稿アップロードエラー: #{error_message}"
      false
    end
  end
  
  def send_fax_transmission(api_token, facsimile_id)
    headers = {
      'Accept' => 'application/json',
      'Authorization' => "token #{api_token}",
      'Content-Type' => 'application/json'
    }
    
    body = {
      use_reservation_notice: false
    }.to_json
    
    response = HTTParty.post(
      "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/#{facsimile_id}/transmission",
      headers: headers,
      body: body
    )
    
    if response.code == 200 || response.code == 201
      true
    else
      result = JSON.parse(response.body) rescue {}
      error_message = result["message"] || result["error"] || "FAX送信に失敗しました。"
      @fax_error = "FAX送信エラー: #{error_message}"
      false
    end
  end
end
