# 03-05 FAXテスト送信結果取得

> HTTPメソッド及び、URL

```
GET /api/v1/facsimiles/:facsimile_id/test_transmissions
```

指定されたFAXのテスト送信結果をCSVデータの一覧形式で取得します。  
（CSVデータの構成は後述のレスポンス欄でご説明します。）   
絞り込み条件としてステータスを指定できます。  
なお、取得対象となる送信結果はFAXテスト送信APIにより作成されるまでは存在しません。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> Query Parameters

```
status=delivery
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/1/test_transmissions?status=non_delivery" \
  -X GET \
  -H "Accept: text/csv" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id <span class="required">必須</span>|FAXID|数値|テスト送信結果を取得したいFAXのID<br/>`/api/v1/facsimiles/:facsimile_id/test_transmissions ` の形式で指定|
|status|ステータス|文字列|指定の値で、取得対象の結果を絞り込む<br/>`delivery`：送達のみ、`non_delivery`：不達のみ、`error`：エラーのみ<br />未設定の場合は指定なしで取得|


## レスポンス

> ボディ

```csv
FAXテスト送信ID,テスト送信先FAX番号,ステータス,確定日時,配信停止,送信エラー,送信エラー詳細
1,0000000000,不達,2019-04-01 18:44,無,不達,話中
```
CSVデータ構成（文字コード: CP932）   
レスポンスのheaderは「content-type:text/csv; charset=utf-8」になりますが、bodyは「CP932」になっています。   
そのため、一部のツールでは正しく読み込みできない場合があります。   
その場合は文字コードを「CP932」に指定して読み込みを行ってください。

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| FAXテスト送信ID | - | 数値 | テストFAX送信時に採番されるID |
| テスト送信先FAX番号 | - | 文字列 | テストFAX送信時に指定したFAX番号 |
| ステータス | - | 文字列 | 送達<br/>不達<br/>送信対象外<br/>エラー|
| 確定日時 | - | 文字列 | 形式はyyyy-mm-dd&nbsp;hh:mi（yyyy:西暦、mm:月、dd:日、hh:時（24時間表記）、mi:分） |
| 送信停止 | - | 文字列 | `有`：送信停止リストに該当した、`無`：送信停止リストに該当していない |
| 送信エラー | - | 文字列 | 送信エラー |
| 送信エラー詳細 | - | 文字列 | 送信エラー詳細 |
