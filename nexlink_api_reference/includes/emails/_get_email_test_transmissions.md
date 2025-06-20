# 04-10 メールテスト送信結果取得

> HTTPメソッド及び、URL

```
GET /api/v1/emails/:email_id/test_transmissions
```

指定されたメールのテスト送信結果をCSVデータの一覧形式で取得します。

取得対象となる送信結果はテスト送信APIにより作成されるまでは存在しません。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/116/test_transmissions" \
  -X GET \
  -H "Accept: text/csv" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|email_id <span class="required">必須</span>|メールID|数値|送信結果を取得したいメールのID<br/>`/api/v1/emails/:email_id/test_transmissions` の形式で指定|


## レスポンス

> ボディ

```csv
メールテスト送信ID,テスト送信メールアドレス,ステータス,確定日時,ステータス詳細
21,test@example.com,送信完了,2018-12-26 09:28,
```
CSVデータ構成（文字コード: CP932）

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| メールテスト送信ID | - | 数値 | テストメール送信時に採番されるID |
| テスト送信メールアドレス | - | 文字列 | テストメール送信時に指定した送信先アドレス |
| ステータス | - | 文字列 | 送信予約中<br/>送信準備中<br/>送信準備完了<br/>送信中<br/>送信完了<br/>エラー |
| 確定日時 | - | 文字列 | 形式はyyyy-mm-dd&nbsp;hh:mi（yyyy:西暦、mm:月、dd:日、hh:時（24時間表記）、mi:分） |
| ステータス詳細 | - | 文字列 | ステータス詳細 |

