# 03-09 FAX原稿削除
> HTTPメソッド及び、URL

```
DELETE /api/v1/facsimiles/:facsimile_id/contents/:content_id
```

指定のFAXに登録されているFAX原稿を削除します。

誤登録した場合など、本APIを使ってFAX原稿を削除します。  
なお、削除できるのは、FAXのステータスが「編集中」の場合のみです。  
  
## リクエスト

> ヘッダ

```
Accept: application/json
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```


> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/252/contents/183"  \
  -d '' -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id <span class="required">必須</span>| FAXID        | 数値   | FAX原稿と関連づくFAXのIDです。<br />`/api/v1/facsimiles/:facsimile_id/contents/:content_id ` の形式で指定します。|
|content_id <span class="required">必須</span>   | FAX原稿ID     | 数値   | 削除するFAX原稿ファイルIDです。<br />`/api/v1/facsimiles/:facsimile_id/contents/:content_id ` の形式で指定します。||

## レスポンス

削除成功時は何も返却されません。

> ステータス

```
204
```


