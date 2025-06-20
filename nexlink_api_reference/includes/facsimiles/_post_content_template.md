# 03-19 FAX自由差込テンプレート設定

> HTTPメソッド及び、URL

```
POST /api/v1/facsimiles/:facsimile_id/contents/:content_id/template
```

指定のFAXに登録されているFAX原稿に、事前に作成した自由差込テンプレートの内容を反映します。

<aside class="warning">
本APIは自由差込のご契約がされている場合のみ実行できます。<br />
　自由差込できるのはFAXの印字内容が「印字指定なし」の場合のみです。<br />
　また、登録に先立ち、以下のチェックを行います。以下に当てはまる場合は登録されません。<br />
<br />&nbsp;&nbsp;&nbsp;・FAX原稿ファイルサイズが全原稿ファイル合計で5MBを超えている
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
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/1/contents/1/template" \
  -d '{"template_id":1,"allow_excess_print_contact":true}' -X POST \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id <span class="required">必須</span>|FAXID|数値| FAX原稿と関連づくFAXのID<br />`/api/v1/facsimiles/:facsimile_id/contents/:content_id/template` の形式で指定|
|content_id <span class="required">必須</span>|FAX原稿ID|数値| 自由差込を行うFAX原稿ファイルのID<br />` /api/v1/facsimiles/:facsimile_id/contents/:content_id/template ` の形式で指定。|
|template_id <span class="required">必須</span>|自由差込テンプレートID|数値|使用する自由差込テンプレートのID|
|allow_excess_print_contact<span class="notice">※1|印字超過宛先を許容する|真偽値|印字する内容がテンプレートに指定した差込項目の最大文字数を超えた宛先について、除外にするかどうかを設定します<br><span class="notice">※1: 送信対象に含める場合、印字内容は最大長で切り捨てられます</span><br><br>`true`: 送信対象に含める、`false`: 印字超過宛先を除外する<br>未設定の場合はfalse<br>|

## レスポンス

> ボディ

```json
{
  "facsimile_id": 324
}
```

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| facsimile_id | FAXID | 数値 |自由差込テンプレートを設定したFAXのID|
