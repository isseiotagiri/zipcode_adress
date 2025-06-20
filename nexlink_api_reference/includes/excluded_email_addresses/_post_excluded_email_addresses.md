# 06-01 停止リスト全停止登録（メール）

> HTTPメソッド及び、URL

```
POST /api/v1/excluded_email_addresses
```

CSV形式の停止リスト全停止（メール）をNEXLINKへ登録します。

登録にあたっては、メールアドレスの妥当性チェックを行います。

登録したメールアドレスは常に送信対象から除外されます。

<aside class="warning">
ファイルには以下の制約があります。<br>
<br>
&nbsp;&nbsp;&nbsp;・ヘッダー項目が「メールアドレス」、「申請者名」、「メモ」のみ<br>
&nbsp;&nbsp;&nbsp;・データ項目が10万行以内<br>
&nbsp;&nbsp;&nbsp;・「申請者名」、「メモ」は最大255文字以内
</aside>

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
Content-Type: multipart/form-data; boundary=----------d86a4f3a380cc091
Cookie:
Origin:
```

> ボディ

```txt
--------------------------d86a4f3a380cc091
Content-Disposition: form-data; name="file"; filename="api_exclu
ded_email_addresses_list.csv"
Content-Type: text/csv

[uploaded data]

--------------------------d86a4f3a380cc091--
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/excluded_email_addresses" \
  -X POST \
  -F 'file=@api_excluded_email_addresses_list.csv;type=text/csv' \
  -H 'Accept: application/json' \
  -H 'Authorization: token YOUR_API_TOKEN' \
```

### パラメータ

| 物理名 | 論理名| 型 | 説明 |
| ---- | ---- | ---- | ---- |
| file <span class="required">必須</span>  | 停止リスト全停止メールアドレスファイル | ファイル | CSV形式、文字コード：CP932 |


## レスポンス

> ボディ

```json
{
    "total_count": 2,
    "success_count": 1,
    "error_count": 1,
    "errors": [
        {
            "row": 1,
            "error_message": "メールアドレスはすでに存在します。",
            "email_address": "test@example.com",
            "end_user_name": null,
            "memo": null
        }
    ]
}
```
| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| total_count | リストの合計件数 | 数値 | CSVファイルのデータ行数  |
| success_count | 登録に成功した件数 | 数値 | 登録に成功した件数 |
| error_count |  登録に失敗した件数|  数値| 登録に失敗した件数 |
| errors<span class="notice">※1</span> |  エラー内容| 文字列 | JSON形式<br>例: メールアドレスが1件登録されなかった場合<br>`"errors": [{"row": 1,"error_message": "メールアドレスはすでに存在します。","email_address": "est@example.com","end_user_name": null,"memo": null}]`<br><br><span class="notice">※1: 全て登録に成功した場合は空の配列となります</span>
