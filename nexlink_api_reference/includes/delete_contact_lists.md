# 01-02 宛先リスト削除

> HTTPメソッド及び、URL

```
DELETE /api/v1/contact_lists/:contact_list_id
```

指定された宛先リストをNEXLINKから削除します。  
宛先リストを誤って登録した際など、本APIを使用して削除します。

## リクエスト

> ヘッダ

```
Accept: application/json
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
Cookie: 
Origin:
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/contact_lists/59" \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|contact_list_id <span class="required">必須</span>|宛先リストID|数値<br />最大20桁|`/api/v1/contact_lists/:contact_list_id` の形式で指定します。|



## レスポンス
削除成功時は何も返却されません。

> ステータス

```
204
```



