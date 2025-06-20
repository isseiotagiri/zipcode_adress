# 02-03 送信停止リスト一覧取得

> HTTPメソッド及び、URL

```
GET /api/v1/exclusion_contact_lists
```

送信停止リストの登録情報を一覧形式で取得することができます。

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
count=2
page=1
name=list
since=2018-12-25T18:34:25+09:00
until=2018-12-31T18:54:38+09:00
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/exclusion_contact_lists?name=list&page=1&count=2&since=2018-12-25T18:34:25+09:00&until=2018-12-31T18:54:38+09:00" \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| count | 取得件数 | 数値 | 1回のリクエストで取得する件数<br/>最大`500`件<br/>未設定の場合は`100` |
| page | 取得ページ番号 | 数値 | 未設定の場合は`1` |
| name | 送信停止リストの名前 | 文字列 | 送信停止リストの名前に含まれる文字列を部分一致検索 |
| since | 登録日(自) | 文字列（ISO8601形式） | この日付以降の登録日で絞り込み |
| until | 登録日(至) | 文字列（ISO8601形式） | この日付以前の登録日で絞り込み |

## レスポンス

> ボディ

```json
{
  "count": 2,
  "page": 1,
  "name": "list",
  "since": "2018-12-25T18:34:25+00:00",
  "until": "2018-12-31T18:54:38+00:00",
  "next_page_url": "https://sandbox-hea.nexlink2.jp/api/v1/exclusion_contact_lists?count=2&name=list&page=2&since=2018-12-25T18%3A34%3A25%2B00%3A00",
  "prev_page_url": null,
  "exclusion_contact_lists": [
    {
      "exclusion_contact_list_id": 11,
      "name": "exclude list2_20181227152453",
      "fax_contact_count": 1,
      "email_contact_count": 1,
      "registed_at": "2018-12-27T15:24:53+09:00"
    },
    {
      "exclusion_contact_list_id": 10,
      "name": "exclude list2",
      "fax_contact_count": 1,
      "email_contact_count": 1,
      "registed_at": "2018-12-27T15:24:42+09:00"
    }
  ]
}
```

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| count | 取得件数 | 数値 | リクエスト時に指定した値 |
| page | ページ番号 | 数値 | リクエスト時に指定した値 |
| name | 送信停止リストの登録名 | 文字列 | リクエスト時に指定した値 |
| since | 登録日（自） | 文字列（ISO8601形式） | リクエスト時に指定した値 |
| until | 登録日（至） | 文字列（ISO8601形式） | リクエスト時に指定した値 |
|next_page_url|次ページurl|文字列|URL<br />次ページが存在しない場合は`null`|
|prev_page_url|前ページurl|文字列|URL<br />前ページが存在しない場合は`null`|
| exclusion_contact_lists | 条件にマッチした送信停止リスト | 配列：個別送信停止リスト | `[個別送信停止リスト...]`<br/>（<span class="notice">以降、個別送信停止リストの項目を記述する</span>） |
| &nbsp;&nbsp;exclusion_contact_list_id | 送信停止リストID | 数値 | 送信停止リストID |
| &nbsp;&nbsp;name | 送信停止リストの登録名 | 文字列 | 送信停止リストの登録名 |
| &nbsp;&nbsp;fax_contact_count | 送信停止先として登録されたFAXの件数 | 数値 | 送信停止先として登録されたFAXの件数 |
| &nbsp;&nbsp;email_contact_count | 送信停止先として登録されたメールアドレスの件数 | 数値 | 送信停止先として登録されたメールアドレスの件数 |
| &nbsp;&nbsp;registed_at | 登録日 | 文字列（ISO8601形式） | 登録日 |
