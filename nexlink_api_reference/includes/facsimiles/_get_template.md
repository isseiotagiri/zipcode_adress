# 03-21 FAX自由差込テンプレート取得

> HTTPメソッド及び、URL

```
GET /api/v1/templates/:template_id
```

指定した自由差込テンプレートを取得することができます。  
自由差込テンプレート IDがわかっており、個別の自由差込テンプレートの内容を確認したい場合には本APIを使用します。

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
curl "https://sandbox-hea.nexlink2.jp/api/v1/templates/1" \ 
  -X GET \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|template_id <span class="required">必須</span>|自由差込テンプレートID|数値|取得したい自由差込テンプレートのID<br/>`/api/v1/templates/:template_id` の形式で指定|

## レスポンス

> ボディ

```json
{
  "template_id": 1,
  "template_name": "パターン1",
  "insertion_columns": "{{会社名}}{{FAX}}",
  "created_user": "created_user",
  "modified_user": "modified_user",
  "created_at": "2019-04-01T18:44:45+09:00",
  "updated_at": "2019-04-01T18:44:45+09:00",
  "content_page": 1,
  "content_vertical_size": 297,
  "content_horizontal_size": 210
}
```
| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| template_id | 自由差込テンプレートID | 数値 | 自由差込テンプレートのID |
| template_name |自由差込テンプレート名 | 文字列 | 自由差込テンプレートの名前 |
| insertion_columns | テンプレートの差込項目 | 文字列 | 自由差込テンプレート内で使用している差込項目<br/>`{{差し込んだ項目1}}{{差し込んだ項目2}}` |
| created_user | 作成者 | 文字列 | 自由差込テンプレートの作成者 |
| modified_user | 更新者 | 文字列 | 自由差込テンプレートの更新者 |
| created_at | 作成日 | 文字列（ISO8601形式） | 自由差込テンプレートの作成日時 |
| updated_at | 更新日 | 文字列（ISO8601形式） | 自由差込テンプレートの更新日時 |
| content_page | 原稿ファイルページ数 | 数値 | テンプレートに使用した原稿ファイルのページ数|
| content_vertical_size | 原稿ファイル縦幅 | 数値 | テンプレートに使用した原稿ファイルの縦幅| 
| content_horizontal_size | 原稿ファイル横幅 | 数値 | テンプレートに使用した原稿ファイルの横幅| 
