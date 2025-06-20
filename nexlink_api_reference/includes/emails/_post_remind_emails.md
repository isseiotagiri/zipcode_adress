# 04-13 リマインドメール作成

> HTTPメソッド及び、URL

```
POST /api/emails/:email_id/remind_emails
```
指定のメールから、リマインドメールを作成します。本APIで送信は行いません。  
作成したメールにはIDを付与します。このIDを使ってメール送信（別API）を行うことで再送信が可能です。  

<aside class="warning">
リマインドメール作成に先立ち、以下のチェックを行います。以下に当てはまる場合は作成できません。<br />
<br />
&nbsp;&nbsp;&nbsp;・メール、もしくは直近のリマインドメールのステータスが「送信完了（エラーありも含む）」以外<br />
&nbsp;&nbsp;&nbsp;・ユニーククリック率(`ユニーククリック数 / 送信完了数`)が100%
</aside>

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/82/remind_emails" \
  -X POST \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|email_id <span class="required">必須</span>|メールID|数値|リマインドメールの作成をしたいメールのID<br/>`/api/emails/:email_id/remind_emails` の形式で指定|



## レスポンス

> ボディ

```json
{
  "email_id": 92,
  "contact_list_id": 1,
  "from_name": "test_from",
  "from_address": "from@example.com",
  "reply_to_address": "reply@example.com",
  "subject": "APIタイトル",
  "email_type": 3,
  "text_body": "おはようございます。\nテキストメールです\nhttp://hoge.com?query=aaa {{添付ファイル名1}}:{{添付ファイルURL1}} ",
  "html_body": "<html><body>こんにちは<br /> HTMLメールです<br /><a href=\"http://huge.com?query=bbb\">リンク</a>{{添付ファイル名1}}:{{添付ファイルURL1}}</body></html>",
  "delivery_name": "remind1_確認メール",
  "allow_duplidate_email_addresses": true,
  "click_log_urls": [
    "http://huge.com?query=bbb",
    "http://hoge.com?query=aaa"
  ],
  "use_beacon": true,
  "exclusion_contact_list_ids": [
    1
  ],
  "notice_mail_addresses": [
    "notice@example.com"
  ],
  "optout_expiration_limit": 10,
  "bill_split_code": null,
  "attachment_ids": [
    80
  ],
  "attachment_expiration_day": 10,
  "email_contact_count": 1,
  "delivery_stop_count": 0,
  "created_at": "2018-12-21T17:27:57+09:00"
}
```
|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|email_id|メールID|数値|リマインドメールのID|
|contact_list_id|宛先リストID|数値|宛先リストのID|
|from_name|差出人名|文字列|メールの差出人名|
|from_address|差出人アドレス|文字列|差出人のメールアドレス|
|reply_to_address|返信先アドレス|文字列|返信先のメールアドレス|
|subject|件名|文字列|メールの件名|
|email_type|メール種別|数値|`1`:テキスト形式、`2`:HTML形式、`3`:マルチパート形式|
|text_body|テキストメール本文|文字列|テキストメールの本文|
|html_body|HTMLメール本文|文字列|HTMLメールの本文|
|delivery_name|案件名|文字列|メールの案件名<br>「remind`n`_元メールの案件名」が自動設定される<br><br>`n` :リマインド回数|
|allow_duplidate_email_addresses|メールアドレス重複除外|真偽値|メールアドレスが重複する宛先があった場合、除外するかどうかの設定<br>`true`:送信対象に含める、`false`:送信対象に含めない|
|click_log_urls|クリックログ対象URL|配列：文字列|クリックログ取得対象のURL|
|use_beacon|開封ログ有無|真偽値|開封ログの取得有無|
|exclusion_contact_list_ids|送信停止リスト|配列:数値|適用した送信停止リストIDの配列<br>`[送信停止リストID...]`|
|notice_mail_addresses|通知メール|配列:文字列|完了通知メールの送信先メールアドレスの配列<br>`["〜@example.com","〜@example.com",...]`|
|optout_expiration_limit|送信停止URL有効期限|数値|日数を指定|
|bill_split_code|請求明細分割コード|文字列|半角英数字・ハイフン・アンダースコアで20桁以内|
|attachment_ids|添付ファイルID|配列:数値|添付ファイルのIDの配列<br>`[添付ファイルID...]`|
|attachment_expiration_day|添付ファイル有効期限|数値|添付ファイルの有効期限|
|email_contact_count|総宛先数|数値|宛先の総件数|
|delivery_stop_count|除外件数|数値|除外した宛先の件数|
|created_at|案件作成日時|文字列（ISO8601形式）|案件を作成した日時|

