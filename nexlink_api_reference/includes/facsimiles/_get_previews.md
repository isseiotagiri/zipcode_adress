# 03-12 FAXプレビュー取得

> HTTPメソッド及び、URL

```
GET /api/v1/facsimiles/:facsimile_id/previews/:page_num
```

FAXのプレビュー画像をページごとに取得出来るAPIです。  
レスポンスとして、PNG形式の画像ファイルが返ります。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Host: sandbox-hea.nexlink2.jp
Content-Type: application/json
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/1/previews/1" \
  -X GET \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id	 <span class="required">必須</span>|FAXID|数値|プレビューを取得したいFAXのID<br/>`/api/v1/facsimiles/:facsimile_id/previews ` の形式で指定|
|page_num <span class="required">必須</span>|ページ番号|数値|取得したいプレビューのページ番号<br/>`/api/v1/facsimiles/:facsimile_id/previews/:page_num` の形式で指定|

## レスポンス

> ステータス

```
200
```


PNG形式の画像ファイルのバイナリデータ
