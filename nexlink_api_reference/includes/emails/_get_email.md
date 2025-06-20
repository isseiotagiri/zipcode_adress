# 04-03 メール取得

> HTTPメソッド及び、URL

```
GET /api/v1/emails/:email_id
```

指定したメールを取得することができます。

メールIDがわかっており、個別のメール内容を確認したい場合には本APIを使用します。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/109" \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|email_id <span class="required">必須</span>|メールID|数値|取得したいメールのID<br/>`/api/v1/emails/:email_id` の形式で指定|

## レスポンス

> ボディ

```json
{
  "email_id": 109,
  "delivery_name": "APIテスト",
  "notice_mail_addresses": [
    "notice@example.com"
  ],
  "exclusion_contact_list_ids": [5],
  "bill_split_code": null,
  "from_name": "差出人",
  "from_address": "from@example.com",
  "reply_to_address": "reply@example.com",
  "subject": "APIテストタイトル",
  "email_type": 1,
  "text_body": "{{会社}}　{{部署}} \r\n{{姓}}　{{名}}様\r\nこんにちは\r\nここhttps://sandbox-hea.nexlink2.jp/api/v1/referencesをクリックしてください。\r\nこちらもご確認ください。\r\n{{添付ファイル名1}}({{添付ファイルURL1}})",
  "html_body": "",
  "email_contact_count": 5,
  "delivery_stop_count": 1,
  "created_at": "2018-12-25T13:01:34+09:00",
  "remind_no": 0,
  "remind_count": 0,
  "remind_ids": [],
  "contact_list_id": 8,
  "status": "done",
  "sent_count": 0,
  "send_error_count": 0,
  "optout_click_count": 0,
  "total_click_count": 0,
  "unique_click_count": 0,
  "beacon_accessed_count": 0,
  "use_beacon": true,
  "optout_expiration_limit": null,
  "created_user": "API",
  "modified_user": "API",
  "reserved_at": "2018-12-25T13:08:34+09:00",
  "sent_at": "2018-12-25T13:08:44+09:00",
  "modified_at": "2018-12-25T13:08:34+09:00",
  "attachment_expired_at": "2019-06-23T13:08:34+09:00",
  "click_log_urls": [
    "https://sandbox-hea.nexlink2.jp/api/v1/references"
  ],
  "attachments": [
    {
      "attachment_id": 42,
      "file_name": "M_1.PDF",
      "file_type": "PDF",
      "url": "https://sandbox-hea.nexlink2.jp/747eca81-8da7-4a90-a4cd-5a99a9ed5b72",
      "file_size": 384,
      "use_click_log": true
    }
  ]
}
```
| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| email_id | メールID | 数値 | メールのID |
| delivery_name | 案件名 | 文字列 | 案件の名前 |
| notice_mail_addresses | 通知メールアドレス | 配列:文字列 | 指定した通知メールアドレスの配列<br/>`[通知メールアドレス...]` |
| exclusion_contact_list_ids | 送信停止リストID | 配列:数値 | 適用した送信停止リストIDの配列<br/>`[送信停止リストID...]` |
| bill_split_code | 請求明細分割コード | 文字列 | 半角英数字・ハイフン・アンダースコアで20桁以内 |
| from_name | 差出人名 | 文字列 | メールの差出人名 |
| from_address | 差出人アドレス | 文字列 | 差出人のメールアドレス |
| reply_to_address | 返信先アドレス | 文字列 | 返信先のメールアドレス |
| subject | 件名 | 文字列 | メールの件名 |
| email_type | メール種別 | 数値 | `1`:テキスト形式、`2`:HTML形式、`3`:マルチパート形式 |
| text_body | テキストメール本文 | 文字列 | テキストメールの本文 |
| html_body | HTMLメール本文 | 文字列 | HTMLメールの本文 |
| email_contact_count | 総宛先数 | 数値 | 宛先の総件数 |
| delivery_stop_count | 除外件数 | 数値 | 除外した宛先の件数 |
| created_at | 案件作成日時 | 文字列（ISO8601形式）　 | 案件を作成した日時 |
| remind_no | リマインド回数 | 数値 | 何回目のリマインドかを表す |
| remind_count | 総リマインド回数 | 数値 | リマインドを行なった総回数 |
| remind_ids | リマインドメールID | 配列:数値 | 送信したリマインドメールのIDの配列<br/>`[リマインドメールID...]` |
| contact_list_id | 宛先リストID | 数値 | 宛先リストのID |
| status | ステータス | 文字列 | `unsent`:&nbsp;編集中<br/>`reserved`:&nbsp;送信予約中<br/>`preparation`:&nbsp;送信準備中<br/>`ready`:&nbsp;送信準備完了<br/>`sending`:&nbsp;送信中<br/>`waiting_for_result`:&nbsp;送信済み（結果確認中）<br/>`done`:&nbsp;送信完了<br/>`error`:&nbsp;送信完了（エラーあり） |
| sent_count | 送信完了数 | 数値 | 送信完了数 |
| send_error_count | 送信エラー数 | 数値 | 送信エラー数 |
| optout_click_count | 送信停止数 | 数値 | 送信停止数 |
| total_click_count | のべクリック数 | 数値 | のべクリック数 |
| unique_click_count | ユニーククリック数 | 数値 | ユニーククリック数 |
| beacon_accessed_count | 開封ログクリック数 | 数値 | 開封ログクリック数 |
| use_beacon | 開封ログ有無 | 数値 | 開封ログの取得有無 |
| optout_expiration_limit | 送信停止URL有効期限|数値|送信完了日からの日数 |
| created_user | 作成者 | 文字列 | 案件の作成者 |
| modified_user | 更新者 | 文字列 | 案件の更新者 |
| reserved_at | 送信予定日 | 文字列（ISO8601形式） | メール送信予約日時 |
| sent_at | 送信完了日 | 文字列（ISO8601形式） | メール送信完了日時 |
| modified_at | 更新日 | 文字列（ISO8601形式） | 案件の更新日時 |
| attachment_expired_at | 添付ファイル有効期限 | 文字列（ISO8601形式） | 添付ファイルの有効期限 |
| click_log_urls | クリックログ設定URL | 配列:文字列 | 指定したクリックログ設定URLの配列<br/>`[クリックログ設定URL...]` |
| attachments | 当該メールに添付した添付ファイル | 配列:添付ファイル | `[添付ファイル..]`<br/>(<span class="notice">以降、添付ファイルの項目を記述する</span>) |
| &nbsp;&nbsp;attachment_id | 添付ファイルID | 数値 | 添付ファイルのID |
| &nbsp;&nbsp;file_name | ファイル名 | 文字列 | 添付ファイル名 |
| &nbsp;&nbsp;file_type | ファイル形式 | 文字列 | 添付ファイルの拡張子の大文字表記(PNGなど) |
| &nbsp;&nbsp;url | 添付ファイルURL | 文字列 | 添付ファイルのURL |
| &nbsp;&nbsp;file_size | 添付ファイルサイズ | 数値 | 添付ファイルのサイズ<br>単位は`KB` |
| &nbsp;&nbsp;use_click_log | クリックログ取得有無 | 真偽値 | `true`: 使用する、`false`: 使用しない |
