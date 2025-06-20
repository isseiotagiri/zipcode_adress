# 02-02 送信停止リスト削除

> HTTPメソッド及び、URL

```
DELETE /api/v1/exclusion_contact_lists/:exclusion_contact_list_id
```

指定された送信停止リストをNEXLINKから削除します。

送信停止リストを誤って登録した際など、本APIを使用して削除します。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/exclusion_contact_lists/5" \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| exclusion_contact_list_id  <span class="required">必須</span>| 送信停止リストのID | 数値 | 削除対象となる送信停止リストのIDです。<br/>`/api/v1/exclusion_contact_lists/:exclusion_contact_list_id`&nbsp;の形式で指定します。 |



## レスポンス

削除成功時は何も返却されません。

> ステータス

```
204
```

