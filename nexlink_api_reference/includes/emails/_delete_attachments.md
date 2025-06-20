# 04-06 メール添付ファイル削除
> HTTPメソッド及び、URL

```
DELETE /api/v1/emails/:email_id/attachments/:attachment_id
```

指定のメールに登録されている添付ファイルを削除します。

誤登録した場合など、本APIを使って添付ファイルを削除します。  
なお、削除できるのは、メールのステータスが「編集中」の場合のみです。
  
## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```


> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/88/attachments/3" \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|email_id <span class="required">必須</span>| メールID        | 数値   | 削除する添付ファイルが登録されているメールのIDです。<br />`/api/v1/emails/:email_id/~` の形式で指定します。|
|attachment_id <span class="required">必須</span>   | 添付ファイルID     | 数値   | 削除する添付ファイルのIDです。<br />` /api/v1/email/:email_id/attachments/:attachment_id` の形式で指定します。||

## レスポンス

削除成功時は何も返却されません。

> ステータス

```
204
```


