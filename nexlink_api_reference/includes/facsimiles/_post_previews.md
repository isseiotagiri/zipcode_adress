# 03-11 FAXプレビュー作成
> HTTPメソッド及び、URL

```
POST /api/v1/facsimiles/:facsimile_id/previews
```

指定されたFAXのプレビュー作成を指示します。  
本APIは作成指示のみであり、FAXプレビューを取得できません。  

<aside class="notice">
FAXプレビューの作成から取得までは以下の流れとなります<br />
<br />
&nbsp;&nbsp;&nbsp;1. FAX原稿をすべて登録した後、本APIを呼び出す<br />
&nbsp;&nbsp;&nbsp;2. プレビュー作成状況をFAX取得APIで確認する<br />
&nbsp;&nbsp;&nbsp;3. FAXプレビュー取得APIでプレビュー画像を取得する
</aside>
  
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
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/218/previews" \
  -d '' -X POST \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json"
```

### パラメータ

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|facsimile_id <span class="required">必須</span>|FAXID|数値|プレビューを作成するFAXのIDです。<br />`/api/v1/facsimiles/:facsimile_id/previews` の形式で指定します。|


## レスポンス

> ボディ

```json
{
  "facsimile_id": 218
}
```

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
| facsimile_id | FAXID | 数値 | プレビューを作成したFAXのIDです。|

