# 04-07 メールテスト送信

> HTTPメソッド及び、URL

```
POST /api/v1/emails/:email_id/test_transmissions
```  
指定したメールのテストメールを作成し、指定のテスト送信先アドレスへ指定のメール種別で送信します。  
ただし、テキストメールとして作成しているメールをHTMLメールとしてテスト送信することは出来ません。  
テスト送信にあたり、テスト送信先アドレスの妥当性チェックを行います。  
レスポンス項目として返すメールIDをテストメール送信結果取得APIに指定することで、テストメール送信結果が取得できます。
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
  "email_address": "test@example.com",
  "email_type":1
}
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/88/test_transmissions" \
  -X POST \
  -d '{"email_type":1,"email_address":"test@example.com"}' \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json" 
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|email_id <span class="required">必須</span>|メールID|数値|テスト送信を行うメールのIDです。<br />`api/v1/emails/:email_id/test_transmissions`の形式で指定します。|
|email_address<span class="required">必須</span>|テスト送信先アドレス|文字列|メールアドレス形式<br /><span class="notice">複数設定は出来ません。</span>|
|email_type<span class="required">必須</span>|メール種別|数値|`1`: テキストメール `2`: HTMLメール|

## レスポンス

> ボディ

```json
{
  "test_email_id": 78,
  "email_id": 88,
  "email_address": "test@example.com",
  "email_type": 1
}
```
|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|test_email_id|テストメールID|数値|テストメール送信時に採番されるID|
|email_id|メールID|数値|メールのID|
|email_address|テスト送信先アドレス|文字列|テストメール送信先アドレス|
|email_type|メール種別|数値|`1`: テキストメール `2`: HTMLメール|


