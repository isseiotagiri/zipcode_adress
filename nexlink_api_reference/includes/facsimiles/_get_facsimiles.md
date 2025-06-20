# 03-03 FAX一覧取得

> HTTPメソッド及び、URL

```
GET /api/v1/facsimiles
```

作成したFAXを一覧形式で取得することができます。

条件を指定することで、取得内容を絞り込むことができます。

## リクエスト

> ヘッダ

```
Accept: application/json
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> Query Parameters

```
status=done
since=2019-04-02T12:00:00+09:00
until=
page=2
count=2
name=test
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles?name=test&status=done&since=2019-04-02T12:00+09:00&count=1&page=1" \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| status | FAXの状態 | 文字列 | `unsent`：編集中<br/>`reserved`：送信予約中<br/>`sending`：送信中<br/>`done`：送信完了<br/>(<span class="notice">`preparation`は`sending`に含まれる<br/> `non_delivery`,`error`は`done`に含まれる</span>) |
| since | 送信予定日(自) | 文字列（ISO8601形式） | この日付以降の送信予定日で絞り込み |
| until | 送信予定日(至) | 文字列（ISO8601形式） | この日付以前の送信予定日で絞り込み |
| count | 取得件数 | 数値 | １回のリクエストで取得する件数<br/>最大`500`件<br/>未設定の場合は`100` |
| page | 取得ページ番号 | 数値 | 未設定の場合は`1` |
| name | FAXの案件名 | 文字列 | FAXの案件名に含まれる文字列を部分一致検索 |


## レスポンス

> ボディ

```json
{
  "name": "test",
  "status": "done",
  "since": "2019-04-02T12:00 09:00",
  "until": null,
  "page": 1,
  "count": 1,
  "next_page_url": "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles?count=1&name=test&page=2&since=2019-04-02T12%3A00+09%3A00&status=done",
  "prev_page_url": null,
  "facsimiles": [
    {
      "facsimile_id": 2083095,
      "delivery_name": "test_4",
      "notice_mail_addresses": [],
      "print_headers": [],
      "print_line_page": 1,
      "print_line_type": 1,
      "fax_quality": 0,
      "fax_speed": 1,
      "delivery_to_count": 2,
      "delivery_stop_count": 0,
      "allow_international_fax": false,
      "allow_duplicate_fax_numbers": false,
      "retry_no": 0,
      "retry_count": 0,
      "use_print_header": false,
      "status": "non_delivery",
      "retry_ids": [],
      "created_at": "2019-04-02T15:05:58+09:00",
      "modified_at": "2019-04-02T15:07:57+09:00",
      "reserved_at": "2019-04-02T15:07:57+09:00",
      "delivery_end_at": "2019-04-02T15:09:06+09:00",
      "contact_list_id": 4649,
      "exclusion_contact_list_ids": [],
      "honorific": 0,
      "bill_split_code": null,
      "successed_count": 1,
      "failed_count": 1,
      "retriable_count": 1,
      "created_user": "API",
      "modified_user": "API",
      "total_content_page": 1,
      "contents": [
        {
          "content_id": 180358,
          "status": "done",
          "file_type": "PDF",
          "error_message": ""
        }
      ]
    }
  ]
}
```

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| name | 案件名 | 文字列 | リクエストの際に指定した値 |
| status | 送信状況 | 文字列 | リクエストの際に指定した値 |
| since | 送信予定日(自) | 文字列（ISO8601形式） | リクエストの際に指定した値 |
| until | 送信予定日(至) | 文字列（ISO8601形式） | リクエストの際に指定した値 |
| count | 取得件数 | 数値 | リクエストの際に指定した値 |
| page | 取得ページ番号 | 数値 | リクエストの際に指定した値 |
| prev_page_url | 前ページurl | 文字列 | URL<br>前ページが存在しない場合は`null` |
| next_page_url | 次ページurl | 文字列 | URL<br>次ページが存在しない場合は`null` |
| facsimiles | 条件にマッチしたFAX | 配列：個別FAX | `[個別FAX、...]`<br/>（<span class="notice">以降、個別FAXの項目を記述する</span>）|
| &nbsp;&nbsp;facsimile_id | FAXID | 数値 | FAXのID |
| &nbsp;&nbsp;delivery_name | 案件名 | 文字列 | 案件の名前 |
| &nbsp;&nbsp;notice_mail_addresses | 通知メールアドレス | 配列 | 指定した通知メールアドレスの配列<br />`[通知メールアドレス...]`` |
| &nbsp;&nbsp;exclusion_contact_list_ids | 送信停止リストID | 配列 | 適用した送信停止リストIDの配列<br />`[送信停止リストID...]` |
| &nbsp;&nbsp;use_print_header | 印字有無 | 真偽値 | `true`:有、`false`:無 |
| &nbsp;&nbsp;print_headers | 印字内容 | 配列 | 設定した印字内容の配列<br />`[印字内容...]` |
| &nbsp;&nbsp;honorific | 敬称コード | 数値 | `0`:敬称なし、`1`:様、`2`:殿、`3`:御中、`4`:先生、`5`:各位 |
| &nbsp;&nbsp;print_line_page | 印字ページ | 数値 | `1`:1枚目のみ、`2`:全ページ |
| &nbsp;&nbsp;print_line_type | 印字方法 | 数値 | `1`:添付貼付、`2`:透明貼付 |
| &nbsp;&nbsp;fax_quality | 送信画質 | 数値 | `0`:ノーマル、`1`:ファイン |
| &nbsp;&nbsp;fax_speed | 送信速度 | 数値 | `0`:スタンダード、`1`:エコノミー |
| &nbsp;&nbsp;allow_international_fax | 海外宛先有無 | 真偽値 | `true`:有、`false`:無 |
| &nbsp;&nbsp;allow_duplicate_fax_numbers | 重複宛先を許容する | 真偽値 | `true`:送信対象煮含める、`false`:重複宛先を除外する |
| &nbsp;&nbsp;bill_split_code | 請求明細分割コード | 文字列 | 半角英数字・ハイフン・アンダースコアで20桁以内 |
| &nbsp;&nbsp;delivery_to_count | 総宛先数 | 数値 | 総宛先数 |
| &nbsp;&nbsp;delivery_stop_count | 除外件数 | 数値 | 除外件数 |
| &nbsp;&nbsp;created_at | 作成日 | 文字列（ISO8601形式）　 | 案件の作成日時 |
| &nbsp;&nbsp;modified_at | 更新日 | 文字列（ISO8601形式） | 案件の更新日時 |
| &nbsp;&nbsp;reserved_at | 送信予定日 | 文字列（ISO8601形式） | FAX送信予定日時 |
| &nbsp;&nbsp;delivery_end_at | 送信完了日 | 文字列（ISO8601形式） | FAX送信完了日時 |
| &nbsp;&nbsp;retry_ids | 再送信FAXID | 配列:数値 | 送信した再送信FAXのIDの配列<br />`[再送信FAXID...]` |
| &nbsp;&nbsp;retry_no | 再送信回数 | 数値 | 何回目の再送信かを表す |
| &nbsp;&nbsp;retry_count | 総再送信回数 | 数値 | 再送信を行った総回数 |
| &nbsp;&nbsp;contact_list_id | 宛先リストID | 数値 | 宛先リストID |
| &nbsp;&nbsp;status | ステータス | 文字列 | `unsent`:&nbsp;編集中<br/>`reserved`:&nbsp;送信予約中<br/>`preparation`:&nbsp;送信準備中<br/>`sending`:&nbsp;送信中<br/>`done`:&nbsp;送信完了<br/>`non_delivery`:&nbsp;送信完了（不達あり）<br />`error`:&nbsp;送信完了（エラーあり） |
| &nbsp;&nbsp;successed_count | 送信完了数 | 数値 | 送信完了数 |
| &nbsp;&nbsp;failed_count | 送信エラー数 | 数値 | 送信エラー数 |
| &nbsp;&nbsp;retriable_count | 再送可能数 | 数値 | 再送可能数 |
| &nbsp;&nbsp;created_user | 作成者 | 文字列 | 案件の作成者 |
| &nbsp;&nbsp;modified_user | 更新者 | 文字列 | 案件の更新者 |
| &nbsp;&nbsp;total_content_page | FAX原稿のページ数 | 数値 | 設定したFAX原稿の総ページ数 |
| &nbsp;&nbsp;contents | 当該FAXに紐づくFAX原稿 | 配列：個別FAX原稿 | `[個別FAX原稿、...]`<br/>（<span class="notice">以降、個別FAX原稿の項目を記述する</span>）|
| &nbsp;&nbsp;&nbsp;&nbsp;content_id | FAX原稿ID | 数値 | FAX原稿ID |
| &nbsp;&nbsp;&nbsp;&nbsp;status | PDF変換ステータス | 文字列 | `done`:&nbsp;PDF変換完了<br />`converting`:&nbsp;PDF変換中<br />`failed`:&nbsp;PDF変換失敗 |
| &nbsp;&nbsp;&nbsp;&nbsp;file_type | FAX原稿ファイル形式 | 文字列 | FAX原稿の拡張子の大文字表記(PNGなど) |
| &nbsp;&nbsp;&nbsp;&nbsp;error_message | エラーメッセージ | 文字列 | PDF変換失敗時のエラーメッセージ |
