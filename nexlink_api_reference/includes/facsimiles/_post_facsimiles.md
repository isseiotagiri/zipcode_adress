# 03-01 FAX新規作成

> HTTPメソッド及び、URL

```
POST /api/v1/facsimiles
```

宛先リストIDで指定した宛先へのFAXを新規に作成します。
作成したFAXにはIDを付与します。このIDを使ってFAX原稿登録やFAX送信等(いずれも別API)を行うことが可能です。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> ボディ

```json
{
  "delivery_name": "年末年始のご挨拶",
  "contact_list_id": 67,
  "notice_mail_addresses": [
    "company@example.com",
    "user2@example.com"
  ],
  "exclusion_contact_list_ids": [
    34
  ],
  "use_print_header": true,
  "print_headers": [
    "1行目: {{会社名}}",
    "2行目: {{FAX}}",
    "3行目: {{部署}}",
    "4行目: {{姓}}{{名}}"
  ],
  "honorific": 2,
  "print_line_page": 1,
  "print_line_type": 1,
  "fax_quality": 0,
  "fax_speed": 1,
  "allow_excess_print_contact": false,
  "allow_international_fax": true,
  "allow_duplicate_fax_numbers": false,
  "bill_split_code": "A_000000-a"
}
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles" \
  -d '{"delivery_name": "年末年始のご挨拶", "contact_list_id": 67, "notice_mail_addresses": ["company@example.com", "user2@example.com"], "exclusion_contact_list_ids": [34], "use_print_header": true, "print_headers": ["1行目: {{会社名}}", "2行目: {{FAX}}", "3行目: {{部署}}", "4行目: {{姓}}{{名}}"], "honorific": 2, "print_line_page": 1, "print_line_type": 1, "fax_quality": 0, "fax_speed": 1, "allow_excess_print_contact": false, "allow_international_fax": true, "allow_duplicate_fax_numbers": false, "bill_split_code": "A_000000-a"}' \
  -X POST \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|contact_list_id <span class="required">必須</span>|宛先リストID|数値|最大20桁|
|use_print_header <span class="required">必須</span>|印字有無|真偽値|FAX原稿の内容とは別に、FAX原稿上部に印字の差込を行うかどうかを設定します。<br>`true`: 印字あり、`false`: 印字なし<br>`true` の場合はパラメータ「印字内容」も指定すること。|
|delivery_name|案件名|文字列|デフォルト値：システム日付の"yyyyMMddHHmmss"形式|
|notice_mail_addresses|通知メールアドレス|配列：文字列|完了通知メールの送信先メールアドレスを複数指定`["〜@example.com","〜@example.com",...]`|
|exclusion_contact_list_ids|送信停止リストID|配列：数値|送信停止リストのIDを複数指定`[1,3,...]`|
|print_headers<span class="notice">※1</span>|印字内容|配列：文字列|差込む印字の内容を設定します<br><span class="notice">※1: 印字有無がtrueの場合のみ必須となります</span><br>宛先リスト(CSV)の値を差込む場合はヘッダ行（1行目）の値を{{}}で囲んで指定します<br><br>[]：印字指定なし<br>[文字列]：1行印字<br>[文字列, 文字列, 文字列, 文字列]：4行印字（なお、空行は空文字列で表す）<br><br>以下に宛先リスト(CSV)のヘッダ行（1行目）が「"会社名", "部署名", "役職名", "氏名", "FAX番号"」である場合の各種例を示す<br><br>例1: 原稿への差込先頭行に「会社名」、2行目に「部署名」、3行目に「役職名」、4行目に「氏名」を設定する場合<br>`["{{会社名}}", "{{部署名}}", "{{役職名}}", "{{氏名}}"]`<br><br>例2: 先頭行を「会社名」「部署名」の複数項目とし、2行目は「役職名」、3行目に「氏名」、4行目に「FAX番号」を設定する場合<br>`["{{会社名}} {{部署名}}", "{{役職名}}", "{{氏名}}", "{{FAX番号}}"]`<br><br>例3: 先頭行、2行目と3行目は例2と同じ。4行目を固定文字列 +「FAX番号」に設定する場合<br>`["{{会社名}} {{部署名}}", "{{役職名}}", "{{氏名}}", "ご送付先 {{FAX番号}}"]`<br>|
|honorific<span class="notice">※2</span>|敬称コード|数値|`0`: 敬称なし、`1`: 様、`2`: 殿、`3`: 御中、`4`: 先生、`5`: 各位<br><br><span class="notice">※2: 1行印字/4行印字の場合のみ指定できます(印字なしの場合常に0が入ります)</span><br>|
|print_line_page<span class="notice">※3</span>|印字ページ|数値|`1`: 1枚目のみ、`2`: 全ページ<br><span class="notice">※3: 4行印字の場合のみ指定でき、かつ、必須となります</span>|
|print_line_type<span class="notice">※4</span>|印字方法|数値|`1`: 添付貼付、`2`: 透明貼付<br><span class="notice">※4: 4行印字の場合のみ指定でき、かつ、必須となります</span>|
|fax_quality|送信画質|数値|`0`: ノーマル、`1`: ファイン<br>未設定の場合は0|
|fax_speed|送信速度|数値|`0`: スタンダード、`1`: エコノミー<br>未設定の場合は1|
|allow_excess_print_contact<span class="notice">※5</span>|印字超過宛先を許容する|真偽値|印字する内容が一行あたりの最大長（全角40文字）を超過した宛先について、除外にするかどうかを設定します<br><span class="notice">※5: 送信対象に含める場合、印字内容は最大長で切り捨てられます</span><br><br>`true`: 送信対象に含める、`false`: 印字超過宛先を除外する<br>未設定の場合はfalse<br>|
|allow_international_fax|海外宛先有無|真偽値|`true`: 有、`false`: 無<br>未設定の場合はfalse|
|allow_duplicate_fax_numbers|重複宛先を許容する|真偽値|FAX番号の重複する宛先があった場合、除外するかどうかを設定します<br><br>`true`: 送信対象に含める、`false`: 重複宛先を除外する<br>未設定の場合はfalse|
|bill_split_code|請求明細分割コード|文字列|半角英数字・ハイフン・アンダースコアで20桁以内|

## レスポンス

> ボディ

```json
{
  "facsimile_id": 301,
  "delivery_name": "年末年始のご挨拶",
  "notice_mail_addresses": [
    "company@example.com",
    "user2@example.com"
  ],
  "print_headers": [
    "1行目: {{会社名}}",
    "2行目: {{FAX}}",
    "3行目: {{部署}}",
    "4行目: {{姓}}{{名}}"
  ],
  "print_line_page": 1,
  "print_line_type": 1,
  "fax_quality": 0,
  "fax_speed": 1,
  "delivery_to_count": 5,
  "delivery_stop_count": 0,
  "allow_international_fax": true,
  "allow_duplicate_fax_numbers": false,
  "use_print_header": true,
  "created_at": "2017-09-07T18:44:46+09:00",
  "contact_list_id": 67,
  "exclusion_contact_list_ids": [
    34
  ],
  "honorific": 2,
  "bill_split_code": "A_000000-a",
  "allow_excess_print_contact": false
}
```

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|（リクエスト時のパラメータすべて）||||
|facsimile_id|FAX ID|数値|FAXのID|
|delivery_to_count|総宛先数|数値|宛先の総件数|
|delivery_stop_count|除外件数|数値|除外した宛先の件数|
|created_at|案件作成日時|文字列（ISO8601形式）|案件を作成した日付|

