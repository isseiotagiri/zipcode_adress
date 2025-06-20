# 06-03 停止リスト全停止一覧取得（メール）

> HTTPメソッド及び、URL

```
GET /api/v1/excluded_email_addresses
```

停止リスト全停止（メール）の登録情報を一覧形式で取得することができます。

条件を指定することで、取得内容を絞り込むことができます。

<aside class="warning">
サーバへの過負荷を避けるため、同時リクエストはご遠慮ください<br>
&nbsp;&nbsp;&nbsp;また、特定のサーバから継続して大量のアクセスがある場合は、アクセスを遮断する等の措置を行う場合があります。<br>
</aside>

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> Query Parameters

```
email_address=test@example.com
end_user_name=end_user_name
memo=memo
count=1
page=2
since=2020-10-01T18:34:38+09:00
until=2020-10-30T18:54:38+09:00
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/excluded_email_addresses?email_address=test@example.com&end_user_name=end_user_name&memo=memo&page=1&count=2&since=2020-10-01T18%3A34%3A38%2B09%3A00&until=2020-10-30T18%3A54%3A38%2B09%3A00" \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN"
```

### パラメータ

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| email_address | メールアドレス | 文字列 | 全停止メールアドレスを部分一致検索 |
| end_user_name | 申請者名 | 文字列 | 申請者名を部分一致検索  |
| memo | メモ | 文字列 | メモを部分一致検索 |
| count	| 取得件数	| 数値	| 1回のリクエストで取得する件数<br>最大`50万`件<br>未設定の場合は`50万` |
| page	|取得ページ番号	 |数値	 |未設定の場合は`1` |
| since	|登録日(自) |	文字列（ISO8601形式） |	この日付以降の登録日で絞り込み |
| until	 |登録日(至)	 |文字列（ISO8601形式） |	この日付以前の登録日で絞り込み |

## レスポンス

> ボディ

```json
{
  "count": 5,
  "page": 1,
  "since": "2020-10-01T18:34:38+09:00",
  "until": "2020-10-30T18:54:38+09:00",
  "next_page_url": "https://sandbox-hea.nexlink2.jp/api/v1/excluded_email_addresses?count=5&page=2",
  "prev_page_url": null,
  "excluded_email_addresses": [
    {
      "email_address": "test+1@example.com",
      "end_user_name": "end_user_name_A",
      "memo": "momo1"
    },
    {
      "email_address": "test+2@example.com",
      "end_user_name": "end_user_name_B",
      "memo": "momo2"
    },
    {
      "email_address": "test+3@example.com",
      "end_user_name": "end_user_name_C",
      "memo": "momo3"
    },
    {
      "email_address": "test+4@example.com",
      "end_user_name": "end_user_name_D",
      "memo": "momo4"
    },
    {
      "email_address": "test+5@example.com",
      "end_user_name": "end_user_name_E",
      "memo": "memo5"
    }
  ]
}

```

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| count |取得件数  | 数値 | リクエスト時に指定した値 |
| page | ページ番号 |数値 | リクエスト時に指定した値 |
| since |登録日（自：絞込条件）  | 文字列（ISO8601形式） | リクエスト時に指定した値 |
| until |登録日（至：絞込条件）  | 文字列（ISO8601形式） | リクエスト時に指定した値 |
| next_page_url | 次ページurl	 | 文字列	 |  URL<br/>次ページが存在しない場合は`null`|
| prev_page_url | 前ページurl | 文字列	 |  URL<br/>前ページが存在しない場合は`null`|
| excluded_email_addresses  | 条件にマッチした停止リスト全停止メールアドレス| 配列:個別停止リスト全停止メールアドレス | `[個別停止リスト全停止メールアドレス...]`<br/>（<span class="notice">以降、個別停止リスト全停止メールアドレスの項目を記述する</span>） |
| &nbsp;&nbsp;email_address | 停止リスト全停止メールアドレス | 文字列 | 停止リスト全停止メールアドレス |
| &nbsp;&nbsp;end_user_name | 申請者 | 文字列 | 申請者 |
| &nbsp;&nbsp;memo| メモ | 文字列 | メモ |
