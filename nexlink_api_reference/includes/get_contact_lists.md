# 01-03 宛先リスト一覧

> HTTPメソッド及び、URL

```
GET /api/v1/contact_lists
```
宛先リストの登録情報を一覧形式で取得することができます。  
条件を指定することで、取得内容を絞り込むことができます。
(条件を省略することもできます。)

## リクエスト

> ヘッダ

```
Accept: application/json
Authorization: token YOUR_API_TOKEN
Host: sandbox-hea.nexlink2.jp
Cookie: 
Origin: 
```

> Query Parameters

```
name=宛先
page=1
count=2
since=2018-12-01T18:34:38+09:00
until=2018-12-31T18:54:38+09:00
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/contact_lists?page=1&count=2&name=%E5%AE%9B%E5%85%88&page=1&count=1&since=2018-12-01T18%3A34%3A38%2B09%3A00&until=2018-12-31T18%3A54%3A38%2B09%3A00" \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|count|取得件数|	数値|最大`500`件<br>未設定の場合は`100`|
|page|取得ページ番号|数値|未設定の場合は`1`|
|since|登録日時(自)|文字列（ISO8601形式）|この日時以降の登録日で絞り込み|
|until|登録日時(至)|文字列（ISO8601形式）|この日時以前の登録日で絞り込み|
|name|宛先リストの登録名|文字列|宛先リストの名前に含まれる文字列を部分一致検索|


## レスポンス

> ボディ

```json
{
  "count": 2,
  "page": 1,
  "name": "宛先",
  "since": "2018-12-01T18:34:38+09:00",
  "until": "2018-12-20T18:54:38+09:00",
  "next_page_url": null,
  "prev_page_url": null,
  "contact_lists": [
    {
      "contact_list_id": 4,
      "name": "stage用宛先.csv",
      "contact_count": {
        "email": 1,
        "fax": 0
      },
      "registed_at": "2018-12-19T18:02:22+09:00"
    }
  ]
}
```
|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|count|取得件数（絞込条件）|数値|未設定の場合は`100`|
|page|ページ番号（絞込条件）|数値|未設定の場合は`1`|
|name|宛先リストの登録名（絞込条件）|文字列|未設定の場合は`null`|
|since|登録日時（自：絞込条件）|文字列（ISO8601形式）|未設定の場合は`null`|
|until|登録日時（至：絞込条件）|文字列（ISO8601形式）|未設定の場合は`null`|
|next_page_url|次ページurl|文字列|URL<br />次ページが存在しない場合は`null`|
|prev_page_url|前ページurl|文字列|URL<br />前ページが存在しない場合は`null`|
|contact_lists|条件にマッチした宛先リスト|配列:個別宛先リスト|`[個別宛先リスト...]`<br />(<span class="notice">以降、個別宛先リストの項目を記述する</span>)|
|&nbsp;&nbsp;contact_list_id|宛先リストID|数値|宛先リストのID|
|&nbsp;&nbsp;name|宛先リストの登録名|文字列|宛先リストの登録名|
|&nbsp;&nbsp;contact_count|登録された宛先件数|文字列|JSON形式<br />例: メールアドレスが1件、FAXが1件登録された場合<br />`"contact_count": { "email": 1, "fax": 1 }`|
|&nbsp;&nbsp;registed_at|登録日|文字列（ISO8601形式）|宛先リストの登録日|


