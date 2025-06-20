# 03-02 FAX更新

> HTTPメソッド及び、URL

```
PUT /api/v1/facsimiles/:facsimile_id
```

指定したFAXを指定した内容で更新します。
更新可能なFAXは、ステータスが「編集中」のものに限ります。削除対象はステータスが「編集中」のみです。

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
  "contact_list_id": 70,
  "notice_mail_addresses": [
    "user@example.com",
    "user2@example.com"
  ],
  "exclusion_contact_list_ids": [
    36
  ],
  "use_print_header": true,
  "print_headers": [
    "1行 {{会社名}}",
    "{{FAX}}",
    "{{部署}}",
    "{{役職}}"
  ],
  "honorific": 2,
  "print_line_page": 2,
  "print_line_type": 2,
  "fax_quality": 1,
  "fax_speed": 0,
  "allow_excess_print_contact": true,
  "allow_international_fax": true,
  "allow_duplicate_fax_numbers": true,
  "bill_split_code": "A_000000-a"
}
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/317" \
  -d '{"delivery_name": "年末年始のご挨拶", "contact_list_id": 70, "notice_mail_addresses": ["user@example.com", "user2@example.com"], "exclusion_contact_list_ids": [36], "use_print_header": true, "print_headers": ["1行 {{会社名}}", "{{FAX}}", "{{部署}}", "{{役職}}"], "honorific": 2, "print_line_page": 2, "print_line_type": 2, "fax_quality": 1, "fax_speed": 0, "allow_excess_print_contact": true, "allow_international_fax": true, "allow_duplicate_fax_numbers": true, "bill_split_code": "A_000000-a"}' \
  -X PUT \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|facsimile_id <span class="required">必須</span>|FAX ID|数値|更新するFAXのIDです。`/api/v1/facsimiles/:facsimile_id `の形式で指定します。|
|allow_excess_print_contact <span class="required">必須</span><span class="notice">※1|印字超過宛先を許容する|真偽値|印字する内容が一行あたりの最大長（全角40文字）を超過した宛先について、除外にするかどうかを設定します<br><span class="notice">※1: 送信対象に含める場合、印字内容は最大長で切り捨てられます</span><br><br>`true`: 送信対象に含める、`false`: 印字超過宛先を除外する<br>|
|use_print_header|印字有無|真偽値|FAX原稿の内容とは別に、FAX原稿上部に印字の差込を行うかどうかを設定します。<br>`true`: 印字あり、`false`: 印字なし<br>`true` の場合はパラメータ「印字内容」も指定すること。|
|delivery_name<span class="notice">※2|案件名|文字列|デフォルト値：システム日付の"yyyyMMddHHmmss"形式<br><span class="notice">※2: 再送信用FAXを更新する場合は本項目を更新できません</span>|
|contact_list_id<span class="notice">※3|宛先リストID|数値|最大20桁<br><span class="notice">※3: 再送信用FAXを更新する場合は本項目を更新できません</span>|
|notice_mail_addresses|通知メールアドレス|配列：文字列|完了通知メールの送信先メールアドレスを複数指定`["〜@example.com","〜@example.com",...]`|
|exclusion_contact_list_ids|送信停止リストID|配列：数値|送信停止リストのIDを複数指定`[1,3,...]`|
|print_headers<span class="notice">※4|印字内容|配列：文字列|差込む印字の内容を設定します<br><span class="notice">※4: 印字有無がtrueの場合のみrequiredとなります</span><br>宛先リスト(CSV)の値を差込む場合はヘッダ行（1行目）の値を{{}}で囲んで指定します<br><br>[]：印字指定なし<br>[文字列]：1行印字<br>[文字列, 文字列, 文字列, 文字列]：4行印字（なお、空行は空文字列で表す）<br><br>以下に宛先リスト(CSV)のヘッダ行（1行目）が「"会社名", "部署名", "役職名", "氏名", "FAX番号"」である場合の各種例を示す<br><br>例1: 原稿への差込先頭行に「会社名」、2行目に「部署名」、3行目に「役職名」、4行目に「氏名」を設定する場合<br>`["{{会社名}}", "{{部署名}}", "{{役職名}}", "{{氏名}}"]`<br><br>例2: 先頭行を「会社名」「部署名」の複数項目とし、2行目は「役職名」、3行目に「氏名」、4行目に「FAX番号」を設定する場合<br>`["{{会社名}} {{部署名}}", "{{役職名}}", "{{氏名}}", "{{FAX番号}}"]`<br><br>例3: 先頭行、2行目と3行目は例2と同じ。4行目を固定文字列 +「FAX番号」に設定する場合<br>`["{{会社名}} {{部署名}}", "{{役職名}}", "{{氏名}}", "ご送付先 {{FAX番号}}"]`<br>|
|honorific<span class="notice">※5|敬称コード|数値|`0`: 敬称なし、`1`: 様、`2`: 殿、`3`: 御中、`4`: 先生、`5`: 各位<br><br><span class="notice">※5: 1行印字/4行印字の場合のみ指定できます(印字なしの場合常に0が入ります)</span><br>|
|print_line_page<span class="notice">※6|印字ページ|数値|`1`: 1枚目のみ、`2`: 全ページ<br><span class="notice">※6: 4行印字の場合のみ指定でき、かつ、必須となります</span>|
|print_line_type<span class="notice">※7|印字方法|数値|`1`: 添付貼付、`2`: 透明貼付<br><span class="notice">※7: 4行印字の場合のみ指定でき、かつ、必須となります</span>|
|fax_quality|送信画質|数値|`0`: ノーマル、`1`: ファイン<br>未設定の場合は0|
|fax_speed|送信速度|数値|`0`: スタンダード、`1`: エコノミー<br>未設定の場合は1|
|allow_international_fax|海外宛先有無|真偽値|`true`: 有、`false`: 無<br>未設定の場合はfalse|
|allow_duplicate_fax_numbers|重複宛先を許容する|真偽値|FAX番号の重複する宛先があった場合、除外するかどうかを設定します<br><br>`true`: 送信対象に含める、`false`: 重複宛先を除外する<br>未設定の場合はfalse|
|bill_split_code|請求明細分割コード|文字列|半角英数字・ハイフン・アンダースコアで20桁以内|

## レスポンス

> ボディ

```json
{
  "delivery_name": "年末年始のご挨拶",
  "contact_list_id": 70,
  "notice_mail_addresses": [
    "user@example.com",
    "user2@example.com"
  ],
  "exclusion_contact_list_ids": [
    36
  ],
  "use_print_header": true,
  "print_headers": [
    "1行 {{会社名}}",
    "{{FAX}}",
    "{{部署}}",
    "{{役職}}"
  ],
  "honorific": 2,
  "print_line_page": 2,
  "print_line_type": 2,
  "fax_quality": 1,
  "fax_speed": 0,
  "allow_excess_print_contact": true,
  "allow_international_fax": true,
  "allow_duplicate_fax_numbers": true,
  "bill_split_code": "A_000000-a"
}
```

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|（リクエスト時のパラメータすべて）||||
|facsimile_id|FAX ID|数値|FAXのID|
|delivery_to_count|総宛先数|数値|宛先の総件数|
|delivery_stop_count|除外件数|数値|除外した宛先の件数|
|created_at|案件作成日時|文字列（ISO8601形式）|案件を作成した日時|
|retry_ids|再送信FAX ID|配列：数値|再送信FAXのID`[310,317,...]`|
|retry_no|再送信回数|数値|何回目の再送信かを表す|
|retry_count|総再送信回数|数値|すべての再送信案件の数|
