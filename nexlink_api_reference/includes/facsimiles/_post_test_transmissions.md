# 03-04 FAXテスト送信

> HTTPメソッド及び、URL

```
POST /api/v1/facsimiles/:facsimile_id/test_transmissions
```

指定したFAXを指定のテスト送信先FAX番号へ送信速度「スタンダード」で送信します。  
テスト送信にあたり、テスト送信先FAX番号の妥当性チェックを行います。  
レスポンス項目として返すFAXテスト送信IDをFAXテスト送信結果取得APIに指定することでFAXテスト送信結果が取得できます。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> ボディ

```json
{
  "fax_number": "000-0000-0001",
  "allow_international_fax": false,
  "quality": 0
}
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/254/test_transmissions" \
  -d '{"fax_number":"000-0000-0001","allow_international_fax":false,"quality":0}' \
  -X POST \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|facsimile_id <span class="required">必須</span>|FAX ID|数値|テスト送信したいFAXのIDです。<br>`/api/v1/facsimiles/:facsimile_id/test_transmissions`の形式で指定します。|
|fax_number <span class="required">必須</span>|テスト送信先となるFAX番号|文字列|テスト送信先となるFAX番号|
|allow_international_fax|海外送信有無|真偽値|`true`: 有、`false`: 無<br>未設定の場合は`false`|
|quality|送信画質|数値|`0`: ノーマル、`1`: ファイン<br>未設定の場合は`0`|

## レスポンス

> ボディ

```json
{
  "test_facsimile_id": 255,
  "facsimile_id": 254,
  "fax_number": "000-0000-0001",
  "allow_international_fax": false,
  "quality": 0
}
```

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|（リクエスト時のパラメータすべて）||||
|test_facsimile_id|FAXテスト送信ID|数値|FAXテスト送信のID|
