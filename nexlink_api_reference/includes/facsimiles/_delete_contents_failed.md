# 03-10 変換失敗FAX原稿一括削除
> HTTPメソッド及び、URL

```
DELETE /api/v1/facsimiles/:facsimile_id/contents/failed
```

指定のFAXに登録されているFAX原稿のうち、OfficeファイルからPDF形式への変換が失敗したものをまとめて削除します。  

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
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/251/contents/failed" \
  -d '' \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id <span class="required">必須</span>| FAXID        | 数値   | FAX原稿と関連づくFAXのIDです。<br />`/api/v1/facsimiles/:facsimile_id/contents/failed` の形式で指定します。|


## レスポンス
> ボディ

```json
{
  "facsimile_id": 251,
  "content_ids": [
    182
  ]
}
```

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
| facsimile_id | FAXID | 数値 | FAXのID |
| content_ids | FAX原稿ID | 配列:数値 | 削除したFAX原稿IDの配列 |

```
