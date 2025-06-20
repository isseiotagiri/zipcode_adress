# 03-18 FAXファイルサイズ取得

> HTTPメソッド及び、URL

```
GET /api/v1/facsimiles/:facsimile_id/file_size
```

FAX原稿のファイルサイズを取得出来るAPIです。  
アップロードした原稿ファイルサイズではなく、FAX送信用にイメージ変換した原稿ファイルサイズです。  
ファイルサイズが小さくなればなるほど、通信エラー（通信の時間切れ・処理量の上限超えなど）が起きにくくなります。  

<aside class="notice">
本APIはFAXプレビュー（FAXプレビュー作成）成功後、取得可能になります。  
</aside>

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/1/file_size" \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id <span class="required">必須</span>|FAXID|数値|FAXファイルサイズを取得したいFAXのID<br/>`/api/v1/facsimiles/:facsimile_id/file_size` の形式で指定|

## レスポンス

> ボディ

```json
{
  "size": 50.78,
  "total_content_page": 1
}
```

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| size | ファイルサイズ | 数値（小数点以下 2桁で切り上げ） | 指定したFAXの原稿のイメージ変換後ファイルサイズ<br>単位は`KB` |
| total_content_page | 原稿ページ数 | 文字列 | FAX原稿のページ数<br />複数原稿を登録していた場合、合算したページ数 |
