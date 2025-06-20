# 04-04 メール一覧取得

> HTTPメソッド及び、URL

```
GET /api/v1/emails
```

作成したメールを一覧形式で取得することができます。

条件を指定することで、取得内容を絞り込むことができます。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> Query Parameters

```
status=done
since=2018-12-25
until=
page=2
count=3
name=テスト
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails?status=done&since=2018-12-25&count=3&page=2&name=%e3%83%86%e3%82%b9%e3%83%88" \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| status | メールの状態 | 文字列 | `unsent`：編集中<br/>`reserved`：送信予約中<br/>`sending`：送信中<br/>`done`：送信完了<br/>(<span class="notice">`preparation`,`ready`は`sending`に含まれる<br/>`waiting_for_result`,`error`は`done`に含まれる</span>) |
| since | 送信予定日(自) | 文字列（ISO8601形式） | この日付以降の送信予定日で絞り込み |
| until | 送信予定日(至) | 文字列（ISO8601形式） | この日付以前の送信予定日で絞り込み |
| count | 取得件数 | 数値 | １回のリクエストで取得する件数<br/>最大`500`件<br/>未設定の場合は`100` |
| page | 取得ページ番号 | 数値 | 未設定の場合は`1` |
|name|メールの案件名|文字列|メールの案件名に含まれる文字列を部分一致検索|


## レスポンス

> ボディ

```json
{
  "name": "テスト",
  "status": "done",
  "since": "2018-12-25",
  "until": null,
  "count": 3,
  "page": 2,
  "next_page_url": null,
  "prev_page_url": "https://sandbox-hea.nexlink2.jp/api/v1/emails?count=3&name=%E3%83%86%E3%82%B9%E3%83%88&page=1&since=2018-12-25T12%3A00+09%3A00&status=done",
  "emails": [
    {
      "email_id": 110,
      "delivery_name": "APIテスト",
      "email_contact_count": 5,
      "sent_count": 1,
      "send_error_count": 0,
      "optout_click_count": 0,
      "total_click_count": 0,
      "unique_click_count": 0,
      "beacon_accessed_count": 0,
      "status": "done",
      "reserved_at": "2018-12-25T13:18:13+09:00",
      "sent_at": "2018-12-25T13:18:22+09:00",
      "bill_split_code": null,
      "created_user": "API",
      "created_at": "2018-12-25T13:16:57+09:00",
      "modified_user": "API",
      "modified_at": "2018-12-25T13:18:13+09:00"
    },
    {
      "email_id": 109,
      "delivery_name": "APIテスト",
      "email_contact_count": 5,
      "sent_count": 0,
      "send_error_count": 0,
      "optout_click_count": 0,
      "total_click_count": 0,
      "unique_click_count": 0,
      "beacon_accessed_count": 0,
      "status": "done",
      "reserved_at": "2018-12-25T13:08:34+09:00",
      "sent_at": "2018-12-25T13:08:44+09:00",
      "bill_split_code": null,
      "created_user": "API",
      "created_at": "2018-12-25T13:01:34+09:00",
      "modified_user": "API",
      "modified_at": "2018-12-25T13:08:34+09:00"
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
| emails | 条件にマッチしたメール | 配列：個別メール | `[個別メール、...]`<br/>（<span class="notice">以降、個別メールの項目を記述する</span>）|
| &nbsp;&nbsp;email_id | メールID | 数値 | メールのID |
| &nbsp;&nbsp;status | ステータス | 文字列 | `unsent`:&nbsp;編集中<br/>`reserved`:&nbsp;送信予約中<br/>`preparation`:&nbsp;送信準備中<br/>`ready`:&nbsp;送信準備完了<br/>`sending`:&nbsp;送信中<br/>`waiting_for_result`:&nbsp;送信済み（結果確認中）<br/>`done`:&nbsp;送信完了<br/>`error`:&nbsp;送信完了（エラーあり） |
| &nbsp;&nbsp;delivery_name | 案件名 | 文字列 | 案件の名前 |
| &nbsp;&nbsp;email_contact_count | 総宛先数 | 数値 | 総宛先数 |
| &nbsp;&nbsp;sent_count | 送信完了数 | 数値 | 送信完了数 |
| &nbsp;&nbsp;send_error_count | 送信エラー数 | 数値 | 送信エラー数 |
| &nbsp;&nbsp;optout_click_count | 送信停止数 | 数値 | 送信停止数 |
| &nbsp;&nbsp;total_click_count | のべクリック数 | 数値 | のべクリック数 |
| &nbsp;&nbsp;unique_click_count | ユニーククリック数 | 数値 | ユニーククリック数 |
| &nbsp;&nbsp;beacon_accessed_count | 開封ログ数 | 数値 | 開封ログクリック数 |
| &nbsp;&nbsp;reserved_at | 送信予定日 | 文字列（ISO8601形式） | メール送信予定日時 |
| &nbsp;&nbsp;sent_at | 送信完了日 | 文字列（ISO8601形式） | メール送信完了日時 |
| &nbsp;&nbsp;bill_split_code | 請求明細分割コード | 文字列 | 半角英数字・ハイフン・アンダースコアで20桁以内 |
| &nbsp;&nbsp;created_user | 作成者 | 文字列 | 案件の作成者 |
| &nbsp;&nbsp;created_at | 作成日 | 文字列（ISO8601形式）　 | 案件の作成日時 |
| &nbsp;&nbsp;modified_user | 更新者 | 文字列 | 案件の更新者 |
| &nbsp;&nbsp;modified_at | 更新日 | 文字列（ISO8601形式） | 案件の更新日時 |

