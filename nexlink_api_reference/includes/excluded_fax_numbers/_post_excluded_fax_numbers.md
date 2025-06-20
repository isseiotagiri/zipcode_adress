# 05-01 停止リスト全停止登録（FAX）

> HTTPメソッド及び、URL

```
POST /api/v1/excluded_fax_numbers
```

CSV形式の停止リスト全停止（FAX）をNEXLINKへ登録します。

登録にあたっては、FAX番号の妥当性チェックを行います。

登録したFAX番号は常に送信対象から除外されます。

<aside class="warning">
ファイルには以下の制約があります。<br>
<br>
&nbsp;&nbsp;&nbsp;・ヘッダー項目が「FAX番号」、「申請者名」、「メモ」のみ<br>
&nbsp;&nbsp;&nbsp;・データ項目が10万行以内<br>
&nbsp;&nbsp;&nbsp;・「申請者名」、「メモ」は最大255文字以内
</aside>

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
Content-Type: multipart/form-data; boundary=----------768d466c102a1474
Cookie:
Origin:
```

> ボディ

```txt
--------------------------768d466c102a1474
Content-Disposition: form-data; name="file"; filename="api_exclu
ded_fax_numbers_list.csv"
Content-Type: text/csv

[uploaded data]

--------------------------768d466c102a1474
Content-Disposition: form-data; name="allow_international_fax"

true
--------------------------768d466c102a1474--
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/excluded_fax_numbers" \
  -X POST \
  -F 'file=@api_excluded_fax_numbers_list.csv;type=text/csv' \
  -F 'allow_international_fax=true' \
  -H 'Accept: application/json' \
  -H 'Authorization: token YOUR_API_TOKEN' \
```

### パラメータ

| 物理名 | 論理名| 型 | 説明 |
| ---- | ---- | ---- | ---- |
| file <span class="required">必須</span>  | 停止リスト全停止FAXファイル | ファイル | CSV形式、文字コード：CP932 |
| allow_international_fax | 海外宛先有無 | 真偽値 | true: 有、false: 無 <br>未設定の場合はfalse |


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
            "error_message": "FAX番号はすでに存在します。",
            "fax_number": "03-XXXX-XXXX",
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
| errors<span class="notice">※1</span> |  エラー内容| 文字列 | JSON形式<br>例: FAX番号が1件登録されなかった場合<br>`"errors": [{"row": 1,"error_message": "FAX番号はすでに存在します。","fax_number": "03-XXXX-XXXX","end_user_name": null,"memo": null}]`<br><br><span class="notice">※1: 全て登録に成功した場合は空の配列となります</span>
