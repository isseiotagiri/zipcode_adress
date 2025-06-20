# 04-02 メール更新

> HTTPメソッド及び、URL

```
PUT /api/v1/emails/:email_id
```

指定したメールを指定した内容で更新します。  
更新可能なメールは、ステータスが「編集中」のものに限ります。  

<aside class="warning">
メール本文には以下の制約があります。<br>
<br>
&nbsp;&nbsp;&nbsp;・1行の文字が900byte以内（テキスト本文のみ）<br>
&nbsp;&nbsp;&nbsp;・本文が200kb以内（テキスト本文、HTML本文の合計）<br>
</aside>

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> ボディ

```json
{
  "contact_list_id": 4,
  "delivery_name": "APIテスト",
  "from_name": "差出人",
  "from_address": "from@example.com",
  "reply_to_address": "reply@example.com",
  "subject": "APIテストタイトル",
  "email_type": 1,
  "text_body": "{{会社}}　{{部署}} \r\n{{姓}}　{{名}}様\r\nこんにちは\r\nここhttps://develop-hea.nexlink2.jp/api/v1/referencesをクリックしてください。\r\nこちらもご確認ください。\r\n{{添付ファイル名1}}({{添付ファイルURL1}})",
  "allow_duplicate_email_addresses": false,
  "click_log_urls": [
    "https://develop-hea.nexlink2.jp/api/v1/references"
  ],
  "use_beacon": true,
  "notice_mail_addresses": [
    "notice@example.com"
  ],
  "attachment_expiration_day":60,
  "bill_split_code":"A_000000-a",
  "exclusion_contact_list_ids":[1] 
}
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/61" \
  -d '{"contact_list_id":4,"delivery_name":"APIテスト","from_name":"差出人","from_address":"from@example.com","reply_to_address":"reply@example.com","subject":"APIテストタイトル","email_type":1,"text_body":"{{会社}} {{部署}} \r\n{{姓}} {{名}}様\r\nこんにちは\r\nここhttps://develop-hea.nexlink2.jp/api/v1/referencesをクリックしてください。\r\nこちらもご確認ください。\r\n{{添付ファイル名1}}({{添付ファイルURL1}})","allow_duplicate_email_addresses":false,"click_log_urls":["https://develop-hea.nexlink2.jp/api/v1/references"],"use_beacon":false,"notice_mail_addresses":["notice@example.com"],"optout_expiration_limit":20,"attachment_expiration_day":60,"bill_split_code":"A_000000-a","exclusion_contact_list_ids":[1]}' \
  -X PUT \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|email_id <span class="required">必須</span>|メールID|数値|更新するメールのIDです。<br>`/api/v1/emails/:email_id `の形式で指定します。|
|contact_list_id<span class="notice">※1</span>|宛先リストID|数値|更新する宛先リストのIDです。<br />最大20桁<br /><span class="notice">※1: リマインドメールを更新する場合は、本項目を更新できません</span>|
|from_name|差出人名|文字列|メールの差出人名|
|from_address|差出人アドレス|文字列|差出人のメールアドレス|
|reply_to_address|返信先アドレス|文字列|返信先のメールアドレス|
|subject|メール件名|文字列|メールの件名<br />255文字以内で指定してください。|
|email_type|メール種別|数値|`1`:テキスト形式、`2`:HTML形式、`3`:マルチパート形式|
|text_body<span class="notice">※2</span>|テキストメール本文|文字列|テキストメール本文を指定します。<br />email_typeが`3`の場合は、マルチパートのテキスト文となります。<br />宛先リスト(CSV)の値を差込む場合はヘッダ行（1行目）の値を`{{}}`で囲んで指定します<br /><br />例：ヘッダ行に`会社名`の項目があり、１行目の内容が`hoge株式会社`の場合:`{{会社名}}様`→１行目の宛先に送信されるメール本文：`hoge株式会社様`<br />宛先リストの値以外に埋め込める項目は、<span class="notice">※6</span>に記載します。<br /><br /><span class="notice">※2: email_type:`1`または`3`の時は空で更新できません</span>|
|html_body<span class="notice">※3</span>|HTMLメール本文|文字列|HTML本文を指定します。<br />email_typeが`3`の場合は、マルチパートのHTML文となります。<br />宛先リスト(CSV)の値を差込む場合はヘッダ行（1行目）の値を`{{}}`で囲んで指定します<br /><br />例：ヘッダ行に`会社名`の項目があり、１行目の内容が`hoge株式会社`の場合:`{{会社名}}様`→１行目の宛先に送信されるメール本文：`hoge株式会社様`<br />宛先リストの値以外に埋め込める項目は、<span class="notice">※6</span>に記載します。<br /><br /><span class="notice">※3: email_type:`2`または`3`の時は空で更新できません</span>|
|delivery_name<span class="notice">※4</span>|案件名|文字列|案件名を指定します<br /><span class="notice">※4: リマインドメールを更新する場合は、本項目を更新できません</span>|
|allow_duplicate_email_addresses|メールアドレス重複除外|真偽値|メールアドレスが重複する宛先があった場合、除外するかどうかを設定します。<br>`true`:送信対象に含める、`false`:送信対象に含めない<br>未設定の場合は`false`|
|click_log_urls|クリックログ対象URL|配列：文字列|クリックログ取得対象のURLを複数指定`["https://~","https:// ~",...]`<br />URLは255文字以内で指定してください。|
|use_beacon<span class="notice">※5</span>|開封ログ有無|真偽値|受信者がメールを開いたかどうかを確認する事ができます。<br>`true`: 取得する、`false`: 取得しない<br>未設定の場合は`false`<br><br><span class="notice">※5: 「取得する」を選択した場合、宛先にHTML形式でメール送信されます。<br>受信者のブラウザ環境によって本文の見え方が異なる場合があります。</span>|
|exclusion_contact_list_ids|送信停止リスト|配列:数値|送信停止リストのIDを複数指定`[1,3,...]`|
|notice_mail_addresses|通知メール|配列:文字列|完了通知メールの送信先メールアドレスを複数指定`["〜@example.com","〜@example.com",...]`|
|optout_expiration_limit|送信停止URL有効期限|数値|日数を指定<br />デフォルト:期限なし<br />指定する場合は`999`までの数値で指定してください。|
|bill_split_code|請求明細分割コード|文字列|半角英数字・ハイフン・アンダースコアで20桁以内|
|attachment_expiration_day|添付ファイル有効期限|数値|日数を指定<br />デフォルト: `180`<br />`180`までの数値で指定してください。|

<aside class="notice">
<span class="notice">※6: 埋め込み項目</span><br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;以下に埋め込み項目を記載します。<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ファイル添付を使用したい場合は、あらかじめメール本文に埋込文字列を設定する必要があります。<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注: 添付ファイルの登録は別APIにて行います。
</aside>



| 埋め込み文字列 | 説明 |
| ---- | ---- |
| {{添付ファイル名n}} | 送信時にn番目に添付したファイルのファイル名に置換されます。<br />例：添付ファイル`sample1.pdf`が登録されていて、メール本文に`ファイル名: {{添付ファイル名1}}`がある場合<br />→送信されるメール本文：`ファイル名: sample1.pdf` |
| {{添付ファイルURLn}} | 送信時にn番目に添付したファイルのファイルのダウンロード用URLに置換されます。<br />例：添付ファイル`sample1.pdf`が登録されていて、メール本文に`<a href="{{添付ファイルURL1}}">{{添付ファイル名1}}をダウンロード</a>`がある場合<br />→送信されるメール本文：`<a href="https://添付ファイルのURL">sample1.pdfをダウンロード</a>` |
| {{添付ファイル有効期限}} |送信時に設定した添付ファイル有効期限の日時に置換されます。<br />（設定していない場合、現在日時の30日後に置換されます）|
| {{送信停止URL}} |送信時に送信停止URLに置換されます。<br />送信停止URL有効期限が設定されている場合、<br />期限外に送信停止URLをクリックしても送信停止出来ません。|

## レスポンス
> ボディ

```json
{
  "email_id": 100,
  "delivery_name": "APIテスト",
  "notice_mail_addresses": [
    "notice@example.com"
  ],
  "exclusion_contact_list_ids": [],
  "bill_split_code": null,
  "from_name": "差出人",
  "from_address": "from@example.com",
  "reply_to_address": "reply@example.com",
  "subject": "APIテストタイトル",
  "email_type": 1,
  "text_body": "{{会社}} {{部署}} \r\n{{姓}} {{名}}様\r\nこんにちは\r\nここhttps://sandbox-hea.nexlink2.jp/api/v1/referencesをクリックしてください。\r\nこちらもご確認ください。\r\n({{添付ファイルURL1}})",
  "html_body": "",
  "email_contact_count": 5,
  "delivery_stop_count": 0,
  "created_at": "2018-12-20T19:16:45+09:00",
  "modified_at": "2018-12-21T18:10:24+09:00",
  "contact_list_id": 7,
  "allow_duplidate_email_addresses": false,
  "use_beacon": true,
  "optout_expiration_limit": null,
  "click_log_urls": [
    "https://develop-hea.nexlink2.jp/api/v1/references"
  ],
  "attachment_expiration_day": null,
  "warning": {
    "deprecated_chars": [],
    "deprecated_tags": []
  }
}
```

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|（リクエスト時のパラメータすべて）||||
|email_id| メールID|数値|メールのID|
|email_contact_count|総宛先数|数値|宛先の総件数|
|delivery_stop_count|除外件数|数値|除外した宛先の件数|
|created_at|案件作成日時|文字列（ISO8601形式）|案件を作成した日時|
|modified_at|案件更新日時|文字列（ISO8601形式）|案件を更新した日時|
|warning|警告|警告|本文内容に関する警告<br>(<span class="notice">以降、警告の項目を記述する</span>)|
|&nbsp;&nbsp;deprecated_chars|非推奨文字列|配列:文字列|著作権表示マーク等、受信者のメールソフトによっては正しく表示されない可能性がある文字<br />例：`©`、`Ⓧ`、`㋐`など|
|&nbsp;&nbsp;deprecated_tags|非推奨HTMLタグ|配列:文字列|HTML本文のみ<br>scriptタグ等、受信者のメールソフトによっては正しく機能しない可能性があるタグ<br />例：`script`、`iframe`、`form`など|
