# 02-01 送信停止リスト登録

> HTTPメソッド及び、URL

```
POST /api/v1/exclusion_contact_lists
```

CSV形式の送信停止リストをNEXLINKへ登録します。

登録にあたっては、FAX番号、メールアドレスの妥当性チェックを行います。

登録した送信停止リストには送信停止リストIDを付与します。FAX新規作成等、他APIで送信停止リストを指定するにはこの送信停止リストIDが必要です。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> ボディ

```txt
--------------------------875ac73dfccb4dab
Content-Disposition: form-data; name="name"

exclude list
--------------------------875ac73dfccb4dab
Content-Disposition: form-data; name="file"; filename="exclusion
_list.csv"
Content-Type: text/csv

[uploaded data]

--------------------------875ac73dfccb4dab
Content-Disposition: form-data; name="mapping_columns"

{ "email": 4,"fax": 5 }
--------------------------875ac73dfccb4dab--
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/exclusion_contact_lists" \
  -X POST \
  -F 'name=exclude list' \
  -F 'file=@exclusion_list.csv;type=text/csv' \
  -F 'mapping_columns={ "email": 4,"fax": 5 }' \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN"
```

### パラメータ

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| name | 送信停止リストの登録名 | 文字列 |未設定の場合は`yyyymmddhh24miss`<br/>（yyyy: 西暦、mm: 月、dd: 日、hh24: 時（24時間表記）、mi: 分、ss: 秒） |
| allow_international_fax | 海外宛先有無 | 真偽値 | `true`: 有、`false`: 無<br/>未設定の場合は`false` |
| file <span class="required">必須</span>| 送信停止リストファイル | ファイル | CSV形式、文字コード：CP932 |
| mapping_columns <span class="required">必須</span>| マッピング列 | 文字列 | NEXLINKでマッピングするカラムが入った列番号をJSONのオブジェクト形式で指定し文字列にしたものを渡す<br/>例: 送信停止リスト(CSV)の列が「メールアドレス、FAX」の順番で並んでいる場合<br/>`'{"email":0,"fax":1}'` |




## レスポンス

> ボディ

```json
{
  "exclusion_contact_list_id": 5,
  "name": "exclude list",
  "notice": [
    "FAXの取り込み件数は1件、エラー件数は0件です。メールの取り込み件数は1件、エラー件数は0件です。"
  ],
  "fax_contact_count": 1,
  "email_contact_count": 1
}
```
| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| exclusion_contact_list_id | 送信停止リストID | 数値 | NEXLINKが発行した送信停止リストのID |
| name | 送信停止リストの登録名 | 文字列 | 送信停止リストの登録名 |
| notice | 処理結果通知 | 配列：文字列 | 処理結果通知 |
| fax_contact_count | 送信停止先として今回登録されたFAXの件数 | 数値 | 送信停止先として今回登録されたFAXの件数 |
| email_contact_count | 送信停止先として今回登録されたメールアドレスの件数 | 数値 | 送信停止先として今回登録されたメールアドレスの件数 |

