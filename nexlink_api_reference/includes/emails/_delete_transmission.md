# 04-09 メール予約キャンセル

> HTTPメソッド及び、URL

```
DELETE /api/v1/emails/:email_id/transmission
```

指定されたメールの送信予約をキャンセルします。  
キャンセル対象となるのはステータスが「送信予約中」であるメールのみです。  
キャンセル後のステータスは「編集中」になります。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```


> サンプルコード

``` shell
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/91/transmission" \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|email_id <span class="required">必須</span>|メールID|数値|送信予約をキャンセルしたいメールのID<br>`/api/v1/emails/:email_id/transmission`の形式で指定|




## レスポンス

キャンセル成功時は何も返却されません。

> ステータス

```
204
```
