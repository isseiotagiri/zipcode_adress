# 03-20 FAX自由差込テンプレート一覧取得

> HTTPメソッド及び、URL

```
GET /api/v1/templates
```

作成した自由差込テンプレートを一覧形式で取得することができます。

<aside class="warning">
本APIは自由差込のご契約がされている場合のみ実行できます。
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
curl "https://sandbox-hea.nexlink2.jp/api/v1/templates" \
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ
なし


## レスポンス

> ボディ

```json
{
  "count": 2,
  "templates": [
    {
      "template_id": 1,
      "template_name": "パターン1",
      "created_user": "created_user",
      "modified_user": "modified_user",
      "created_at": "2019-04-01T18:44:45+09:00",
      "updated_at": "2019-04-01T18:44:45+09:00"
    },
    {
      "template_id": 2,
      "template_name": "パターン２",
      "created_user": "created_user",
      "modified_user": "modified_user2",
      "created_at": "2019-04-01T18:44:45+09:00",
      "updated_at": "2019-04-01T18:44:45+09:00"
    }    
  ]
}
```

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
|count| テンプレート数 | 数値 | 取得した自由差込テンプレートの数 |
|templates| 取得した自由差込テンプレート| 配列：自由差込テンプレート | `[自由差込テンプレート、...]`<br/>（<span class="notice">以降、自由差込テンプレートの項目を記述する</span>）|
|&nbsp;&nbsp;template_id| テンプレートID | 数値 | 自由差込テンプレートのID |
|&nbsp;&nbsp;template_name|テンプレート名| 文字列 | テンプレートの名称|
|&nbsp;&nbsp;created_user| 作成者 | 文字列 | 作成者の名前 |
|&nbsp;&nbsp;modified_user| 更新者 |文字列  | 最終更新者の名前 |
|&nbsp;&nbsp;created_at| 作成日 | 文字列（ISO8601形式）|作成日時| 
|&nbsp;&nbsp;updated_at| 更新日 | 文字列（ISO8601形式）|更新日時|

