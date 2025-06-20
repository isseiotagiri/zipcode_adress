# 04-12 メール削除

> HTTPメソッド及び、URL

```
DELETE /api/v1/emails/:email_id
```

指定されたメールを削除します。    
キャンセル対象となるのはステータスが「編集中」もしくは「送信予約中」であるメールのみです。    
削除に伴い、本メールに登録されている添付ファイルも削除されます。一方、宛先リスト、送信停止リストは削除されません。
## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```


> サンプルコード

``` shell
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/10" \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|email_id <span class="required">必須</span>|メールID|数値|最大20桁<br>`/api/v1/emails/:email_id`の形式で指定|




## レスポンス

削除成功時は何も返却されません。

> ステータス

```
204
```
