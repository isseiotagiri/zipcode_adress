# 01 SMS配信登録

> HTTPメソッド及び、URL

```
POST /api/v1/delivery
```

SMS配信を登録し、指定宛先一覧にメッセージ本文を送ります。

- 本APIで下記の配信処理を行うことができます。

  - 直接携帯電話番号を指定してダイレクトに配信します。

  - 配信本文を直接指定して配信します。

- 以下のオプションを指定することで、配信のバリエーションを増やすことができます。

  - 本文内のURLのクリックカウントを集計します。

  - 配信予定日時を指定して配信します。

なお、本APIは、最大5万宛先まで配信可能です。

## リクエスト

> ヘッダ

```
Accept:       application/json
token:        YOUR_API_TOKEN
Content-Type: application/json
Host:         sand-api-smslink.nexlink2.jp
```

> ボディ

```json
{
  "contacts": [
    {
      "phone_number": "090xxxxxxxx"
    }
  ],
  "text_message": " こんにちはここ https://sand-api-smslink.nexlink2.jp をクリックしてください{{配信停止URL}}",
  "reserved_at": "",
  "click_count": true,
  "notification_emails": [
    "<実在するメールアドレス>"
  ]
}
```

> サンプルコード

``` sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/delivery" \
  -X POST \
  -d '{"contacts":[{"phone_number":"090xxxxxxxx"}],"text_message":" こんにちはここ https://sand-api-smslink.nexlink2.jp をクリックしてください{{配信停止URL}}","reserved_at":"","click_count":true,"notification_emails":["<実在するメールアドレス>"]}' \
  -H "Accept:       application/json" \
  -H "token:        YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

<table>
  <tr>
    <th class="container">項番</th>
    <th class=>物理名</th>
    <th class=>論理名</th>
    <th class=>型</th>
    <th>必須</th>
    <th class=>制約</th>
    <th class=>説明</th>
  </tr>
  <tr>
    <td class="container">1</td>
    <td>delivery_name</td>
    <td>案件名</td>
    <td>文字列</td>
    <td></td>
    <td>最大255文字</td>
    <td>案件名を指定しない場合、システム日付をyyyyMMddHHmmssの形式に自動生成される</td>
  <tr>
  <tr>
    <td class="container">2</td>
    <td>contacts</td>
    <td>宛先一覧</td>
    <td>配列：個別宛先</td>
    <td>○</td>
    <td>最大50,000件</td>
    <td>配信の宛先一覧</td>
  <tr>
  <tr>
    <td class="container">2-1</td>
    <td>phone_number</td>
    <td>携帯電話番号</td>
    <td>文字列</td>
    <td>○</td>
    <td></td>
    <td>配信宛先の携帯電話番号<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">2-2</td>
    <td>insertion_item1</td>
    <td>差込項目1</td>
    <td>文字列</td>
    <td></td>
    <td>最大255文字</td>
    <td>本文に差し込む場合は {{insertion_item1}}と入力する</td>
  </tr>
  <tr>
    <td class="container">2-3</td>
    <td>insertion_item2</td>
    <td>差込項目2</td>
    <td>文字列</td>
    <td></td>
    <td>最大255文字</td>
    <td>本文に差し込む場合は {{insertion_item2}}と入力する</td>
  </tr>
  <tr>
    <td class="container">2-4</td>
    <td>insertion_item3</td>
    <td>差込項目3</td>
    <td>文字列</td>
    <td></td>
    <td>最大255文字</td>
    <td>本文に差し込む場合は {{insertion_item3}}と入力する</td>
  </tr>
  <tr>
    <td class="container">2-5</td>
    <td>insertion_item4</td>
    <td>差込項目4</td>
    <td>文字列</td>
    <td></td>
    <td>最大255文字</td>
    <td>本文に差し込む場合は {{insertion_item4}}と入力する</td>
  </tr>
  <tr>
    <td class="container">2-6</td>
    <td>insertion_item5</td>
    <td>差込項目5</td>
    <td>文字列</td>
    <td></td>
    <td>最大255文字</td>
    <td>本文に差し込む場合は {{insertion_item5}}と入力する</td>
  </tr>
  <tr>
    <td class="container">2-7</td>
    <td>insertion_url1</td>
    <td>差込短縮URL1</td>
    <td>文字列</td>
    <td></td>
    <td>URL形式</td>
    <td>
      本文に差し込む場合は {{insertion_url1}}と入力する。<br>
      URLは短縮して配信され、クリックカウントを取得する。
    </td>
  </tr>
  <tr>
    <td class="container">2-8</td>
    <td>insertion_url2</td>
    <td>差込短縮URL2</td>
    <td>文字列</td>
    <td></td>
    <td>URL形式</td>
    <td>
      本文に差し込む場合は {{insertion_url2}}と入力する。<br>
      URLは短縮して配信され、クリックカウントを取得する。
    </td>
  </tr>
  <tr>
    <td class="container">3</td>
    <td>text_message</td>
    <td>本文</td>
    <td>文字列</td>
    <td>○</td>
    <td>最大660文字</td>
    <td>配信の本文<span class="asterisk">※2</span></td>
  </tr>
  <tr>
    <td class="container">4</td>
    <td>reserved_at</td>
    <td>配信予定日時</td>
    <td>文字列</td>
    <td></td>
    <td>ISO8601形式</td>
    <td>配信予約時刻(過去の時刻または1年より先の時刻は指定できません)10分刻みの指定として扱う。<br>
        10分未満の時刻は切り上げて (+10分として)扱う。<br>
        設定しない場合、即時で配信する。</td>
  </tr>
  <tr>
    <td class="container">5</td>
    <td>click_count</td>
    <td>クリックカウント取得</td>
    <td>真偽値</td>
    <td></td>
    <td></td>
    <td>true:する<br>
        false:しない<br>
        指定しない場合、falseとなる。</td>
  </tr>
  <tr>
    <td class="container">6</td>
    <td>notification_emails</td>
    <td>結果通知メール</td>
    <td>配列：文字列</td>
    <td></td>
    <td>最大5件</td>
    <td>完了通知メールの送信先</td>
  </tr>
  <tr>
    <td class="container">7</td>
    <td>bill_split_code</td>
    <td>請求明細分割コード</td>
    <td>文字列</td>
    <td></td>
    <td>最大20文字</td>
    <td>請求明細を分割コード毎に作成する。<br>
        使用可能文字は半角英数字 、 -(半角ハイフン)、 _(半角アンダースコア)<br>
        「auto_reply」と「smslink_verify」はシステム側で利用するため、使用しないでください</td>
  </tr>
</table>

<span class="asterisk">※1</span>携帯電話番号の仕様は以下になります。

  - 070,080,090から始まる11桁の番号。ただし、0800から始まる11桁の番号には配信できません。

  - 020から始まる11桁か14桁の番号。

  - 先頭に「+81」を指定した場合「0」に変換されます。

  - 海外キャリアには配信できません。

  - 「‒(ハイフン)」は省略できます。

  - 全角数字は半角に変換されます。

<br>

<span class="asterisk">※2</span>本文の仕様は以下になります。

  - メッセージ本文をUTF-8エンコードにて設定してください。

  - 4バイト文字は使用できません。

  - 改行コードは全てCRLFに変換され、2文字でカウントされます。

  - クリックカウントを取得する場合、URLは最大2件まで指定できます。

  - クリックカウントを取得する場合、URLは短縮して配信されます。

  - 配信停止URLを利用する場合は{{配信停止URL}}を入力してください。

  - URLを入れる場合、前後に半角スペースまたは改行を挿入してください。

## レスポンス

> ボディ

```json
{
  "delivery_id": "fd75dc2503c20bb62902fabbbddf98e3",
  "accepted_at": "2018-06-19T16:11:56+09:00",
  "reserved_at": "2018-06-19T16:11:56+09:00",
  "contacts": [
    {
      "contact_id": 1,
      "phone_number": "090xxxxxxxx",
      "result_code": "RST200001",
      "result_message": "配信対象に登録しました。"
    }
  ],
  "click_count_urls": [
    "https://sand-api-smslink.nexlink2.jp"
  ]
}

```

<table>
  <tr>
    <th class="container">項番</th>
    <th>物理名</th>
    <th>論理名</th>
    <th>型</th>
    <th>制約</th>
    <th>説明</th>
  </tr>
  <tr>
    <td class="container">1</td>
    <td>delivery_id</td>
    <td>配信ID</td>
    <td>文字列</td>
    <td>最大50文字</td>
    <td>SMSLINKが発行した配信ID</td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>accepted_at</td>
    <td>受付日時</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>配信受付日時（YYYY-MM-DDThh:mm:ss+09:00形式）</td>
  </tr>
  <tr>
    <td class="container">3</td>
    <td>reserved_at</td>
    <td>配信予定日時</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>配信予定日時（YYYY-MM-DDThh:mm:ss+09:00形式）</td>
  </tr>
  <tr>
    <td class="container">4</td>
    <td>contacts</td>
    <td>宛先一覧</td>
    <td>配列</td>
    <td></td>
    <td>配信の宛先別情報一覧</td>
  </tr>
  <tr>
    <td class="container">4-1</td>
    <td>contact_id</td>
    <td>宛先ID</td>
    <td>数値</td>
    <td>最大20桁</td>
    <td>SMSLINKが発行した宛先ID</td>
  </tr>
  <tr>
    <td class="container">4-2</td>
    <td>phone_number</td>
    <td>宛先の携帯電話番号</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>リクエストで指定した携帯電話番号</td>
  </tr>
  <tr>
    <td class="container">4-3</td>
    <td>result_code</td>
    <td>結果コード</td>
    <td>文字列</td>
    <td>最大10文字</td>
    <td>結果コード・結果メッセージ一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">4-4</td>
    <td>result_message</td>
    <td>結果メッセージ</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>結果コード・結果メッセージ一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">5</td>
    <td>click_count_urls</td>
    <td>クリックカウント取得対象URL</td>
    <td>配列：文字列</td>
    <td>最大660文字</td>
    <td>クリックカウント取得対象のURL<br>
        指定しない場合、空の配列となる。</td>
  </tr>
</table>
<br/>

<span class="asterisk">※1</span>　結果コード・結果メッセージ一覧

|result_code|result_message|説明|
| --- | --- | --- |
|RST200001|配信対象に登録しました|正常に登録されました|
|RST200002|携帯電話番号がない為、配信対象に登録できませんでした|携帯電話番号が未入力です|
|RST200003|携帯電話番号が11桁か14桁でない為、配信対象に登録できませんでした|携帯電話番号の桁数不足または桁数超えしています|
|RST200004|携帯電話番号が重複した為、配信対象に登録できませんでした|宛先一覧の携帯電話番号が重複したため除外されました|
|RST200005|配信不可な電話番号の為、配信対象に登録できませんでした|携帯電話番号の形式ではありません|
|RST200006|宛先項目が255文字を超えてる為、配信対象に登録できませんでした|宛先項目が桁数超えしています|
|RST200007|差込項目に使用できない文字がある為、配信対象に登録できませんでした|差込項目に使用できない文字が含まれています|
|RST200008|本文が差込項目含めて660文字を超えてる為、配信対象に登録できませんでした|本文が桁数超えしています|
