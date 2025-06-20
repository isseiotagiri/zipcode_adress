# 03-07 FAX取得

> HTTPメソッド及び、URL

```
GET /api/v1/facsimiles/:facsimile_id
```

指定したFAXを取得することができます。  

FAX IDがわかっており、個別のFAX内容を確認したい場合には本APIを使用します。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/1" \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id <span class="required">必須</span>|FAXID|数値|情報を表示するFAXのID<br/>`/api/v1/facsimiles/:facsimile_id ` の形式で指定|

## レスポンス

> ボディ

```json
{
  "facsimile_id": 1,
  "delivery_name": "fax_sample",
  "notice_mail_addresses": [],
  "print_headers": [],
  "print_line_page": 1,
  "print_line_type": 1,
  "fax_quality": 0,
  "fax_speed": 0,
  "delivery_to_count": 0,
  "delivery_stop_count": 0,
  "allow_international_fax": false,
  "allow_duplicate_fax_numbers": false,
  "retry_no": 0,
  "retry_count": 0,
  "use_print_header": false,
  "status": "unsent",
  "retry_ids": [],
  "created_at": "2017-09-07T18:44:46+09:00",
  "modified_at": "2017-09-07T18:44:46+09:00",
  "reserved_at": null,
  "delivery_end_at": null,
  "contact_list_id": null,
  "exclusion_contact_list_ids": [],
  "honorific": 0,
  "bill_split_code": null,
  "successed_count": 0,
  "failed_count": 0,
  "retriable_count": 0,
  "created_user": "user4",
  "modified_user": "user4",
  "total_content_page": 1,
  "contents": [
    {
      "content_id": 225,
      "status": "done",
      "file_type": "JPEG",
      "error_message": ""
    }
  ],
  "preview_created_at": "2017-09-07T18:44:47+09:00",
  "preview_status": "converting",
  "preview_page_num": 1,
  "preview_pages": [
    "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/304/previews/1"
  ]
}
```

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|facsimile_id|FAXID|数値|取得したFAXのID|
|delivery_name|案件名|文字列|FAXの案件名|
|notice_mail_addresses|通知メール|配列:文字列|完了通知メールの送信先メールアドレスの配列<br>`["〜@example.com","〜@example.com",...]`|
|print_headers| 印字内容 |配列|[]：印字指定なし<br />[文字列]：1行印字<br>[文字列, 文字列, 文字列, 文字列]：4行印字（なお、空行は空文字列で表す）<br><br>以下に宛先リスト(CSV)のヘッダ行（1行目）が「"会社名", "部署名", "役職名", "氏名", "FAX番号"」である場合の各種例を示す<br><br>例1: 原稿への差込先頭行に「会社名」、2行目に「部署名」、3行目に「役職名」、4行目に「氏名」を設定する場合<br>`["{{会社名}}", "{{部署名}}", "{{役職名}}", "{{氏名}}"]`<br><br>例2: 先頭行を「会社名」「部署名」の複数項目とし、2行目は「役職名」、3行目に「氏名」、4行目に「FAX番号」を設定する場合<br>`["{{会社名}} {{部署名}}", "{{役職名}}", "{{氏名}}", "{{FAX番号}}"]`<br><br>例3: 先頭行、2行目と3行目は例2と同じ。4行目を固定文字列 +「FAX番号」に設定する場合<br>`["{{会社名}} {{部署名}}", "{{役職名}}", "{{氏名}}", "ご送付先 {{FAX番号}}"]` |
|print_line_page|印字ページ|数値|`1`:1枚目のみ、`2`:全ページ|
|print_line_type|印字方法|数値|`1`:添付貼付、`2`:透明貼付|
|fax_quality|送信画質|数値|`0`:ノーマル、`1`:ファイン|
|fax_speed|送信速度|数値|`0`:スタンダード、`1`:エコノミー|
|delivery_to_count | 総宛先数 | 数値 | 総宛先数 |
|delivery_stop_count | 除外件数 | 数値 | 除外件数 |
|allow_international_fax | 海外宛先有無 | 真偽値 | `true`:有、`false`:無 |
|allow_duplicate_fax_numbers | 重複宛先を許容する | 真偽値 | `true`:送信対象煮含める、`false`:重複宛先を除外する |
|retry_no | 再送信回数 | 数値 | 何回目の再送信かを表す |
|retry_count | 総再送信回数 | 数値 | 再送信を行った総回数 |
|use_print_header|印字有無|真偽値|`true`:有、`false`:無|
|status|ステータス|文字列|`unsent`:&nbsp;編集中<br/>`reserved`:&nbsp;送信予約中<br/>`preparation`:&nbsp;送信準備中<br/>`sending`:&nbsp;送信中<br/>`done`:&nbsp;送信完了<br/>`non_delivery`:&nbsp;送信完了（不達あり）<br />`error`:&nbsp;送信完了（エラーあり）|
|retry_ids| 再送信FAXID | 配列:数値 | 送信した再送信FAXのIDの配列<br />`[再送信FAXID...]` |
|created_at|作成日|文字列（ISO8601形式）|案件の作成日時|
|modified_at|更新日|文字列（ISO8601形式）|案件の更新日時|
|reserved_at|送信予定日|文字列（ISO8601形式）|FAX送信予定日時|
|delivery_end_at|送信完了日|文字列（ISO8601形式）|FAX送信完了日時|
|contact_list_id | 宛先リストID | 数値 | 宛先リストID |
|exclusion_contact_list_ids|送信停止リスト|配列:数値|適用した送信停止リストIDの配列<br>`[送信停止リストID...]`|
|honorific|敬称コード|数値|`0`:敬称なし、`1`:様、`2`:殿、`3`:御中、`4`:先生、`5`:各位|
|bill_split_code|請求明細分割コード|文字列|半角英数字・ハイフン・アンダースコアで20桁以内|
|successed_count|送信完了数|数値|送信完了数|
|failed_count|送信エラー数|数値|送信エラー数|
|retriable_count|再送可能数|数値|再送可能数|
|created_user|作成者|文字列|案件の作成者|
|modified_user|更新者|文字列|案件の更新者|
|total_content_page|FAX原稿のページ数|数値|設定したFAX原稿の総ページ数|
|contents|当該FAXに紐づくFAX原稿|配列：個別FAX原稿|`[個別FAX原稿、...]`<br/>（<span class="notice">以降、個別FAX原稿の項目を記述する</span>）|
|&nbsp;&nbsp;content_id|FAX原稿ID|数値|FAX原稿ID|
|&nbsp;&nbsp;status|PDF変換ステータス|文字列|`done`:&nbsp;PDF変換完了<br />`converting`:&nbsp;PDF変換中<br />`failed`:&nbsp;PDF変換失敗|
|&nbsp;&nbsp;file_type|FAX原稿ファイル形式|文字列|FAX原稿の拡張子の大文字表記(PNGなど)|
|&nbsp;&nbsp;error_message|エラーメッセージ|文字列|PDF変換失敗時のエラーメッセージ|
|&nbsp;&nbsp;template_id<span class="notice">※1</span>|自由差込テンプレートID|数値|<span class="notice">※1: </span>自由差込が有効の場合のみ表示|
|preview_created_at|プレビュー作成受付時刻|文字列（ISO8601形式）|FAXプレビューがない場合は`null`|
|preview_status|プレビュー変換状況|文字列|`finished`: 変換成功、`failed`: 変換失敗、`validation_failed`: 変換失敗(FAX送信出来ない状態)、 `converting`: 変換中|
|preview_page_num|プレビューページ数|数値|FAXプレビューがない場合は`null`|
|preview_pages|プレビュー取得URL|配列：文字列(URL形式) |プレビュー取得APIのエンドポイントURLの配列がページ順に並んだ配列<br />プレビュー変換が終了しているページのURLのみ取得|
