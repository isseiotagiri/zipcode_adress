# 01-01 宛先リスト登録

> HTTPメソッド及び、URL

```
POST /api/v1/contact_lists
```

CSV形式の宛先リストをNEXLINKへ登録します。

差込みに使用するマッピング情報（項目との関連づけ）も併せて指定します。
登録にあたっては、メールアドレスの妥当性チェックを行います。なお、指定によってはチェック結果がNGであっても、空欄として登録することが可能です。

登録した宛先リストには宛先リストIDを付与します。メール作成等、他APIで宛先リストを指定するにはこの宛先リストIDが必要です。

## リクエスト

> ヘッダ

```
Accept: application/json
Authorization: token YOUR_API_TOKEN
Host: sandbox-hea.nexlink2.jp
Content-Type: multipart/form-data; boundary=----------XnJLe9ZIbbGUYtzPQJ16u1
Cookie: 
Origin:
```

> ボディ

```
--------------------------031e3d5b757a413b
Content-Disposition: form-data; name="name"

file name
--------------------------031e3d5b757a413b
Content-Disposition: form-data; name="mapping_columns"

{ "email": 0, "fax": 1 }
--------------------------031e3d5b757a413b
Content-Disposition: form-data; name="file"; filename="api_conta
ct_lists.csv"
Content-Type: text/csv

[uploaded data]

--------------------------031e3d5b757a413b--
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/contact_lists" \
  -F 'name=file name' \
  -F 'mapping_columns={ "email": 0, "fax": 1 }' \
  -F 'file=@api_contact_lists.csv;type=text/csv' \
  -X POST \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|file <span class="required">必須</span>|宛先リストファイル|ファイル|CSV形式、文字コード：CP932
|name|宛先リストの登録名|文字列|宛先リストの登録名|
|ignore_error_fields|エラー項目を空欄にして取り込むか|真偽値|`true`: 取り込む、`false`: 取り込まずエラーとして扱う<br>未設定の場合は`false`|
|mapping_columns <span class="required">必須</span>|マッピング設定|文字列|NEXLINKでマッピングするカラムが入った列番号をJSONのオブジェクト形式で指定し文字列にしたものを渡す<br />例: 宛先リスト(CSV)の列が「メールアドレス、FAX、会社名、部署、役職、姓、名、郵便番号」の順番で並んでいて、メール用宛先とFAX用宛先を作成したい場合<br />`{"email":0,"fax":1}`|

## レスポンス

> ボディ

```json
{
  "contact_list_id": 66,
  "name": "file name",
  "contact_count": {
    "email": 1,
    "fax": 1
  }
}
```
|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|contact_list_id|宛先リスト|数値|登録した宛先リストのID|
|name|宛先リストの登録名|文字列|宛先リストの登録名|
|contact_count|登録された宛先件数（JSON形式）|文字列|例: メール用宛先が1件、FAX用宛先が1件登録された場合<br />` "contact_count": { "email": 1, "fax": 1 } `|


