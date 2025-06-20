# 03-06 FAX削除

> HTTPメソッド及び、URL

```
DELETE /api/v1/facsimiles/:facsimile_id
```

指定されたFAXを削除します。  
削除対象はステータスが「編集中」のみです。  
削除に伴い、本FAXに登録されているFAX原稿も削除されます。一方、宛先リスト、送信停止リストは削除されません。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/316" \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|facsimile_id <span class="required">必須</span>|FAX ID|数値|削除するFAXのIDです。<br>`/api/v1/facsimiles/:facsimile_id `の形式で指定します。|



## レスポンス

> ステータス

```
204
```

削除成功時は何も返却されません。
