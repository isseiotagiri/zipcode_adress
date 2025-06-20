# 03-16 FAX再送信

> HTTPメソッド及び、URL

```
POST /api/v1/facsimiles/:facsimile_id/retry
```

指定のFAXから、再送信用FAXを作成します。本APIで送信は行いません。  
作成したFAXにはIDを付与します。このIDを使ってFAX送信（別API）を行うことで再送信が可能です。

<aside class="warning">
再送信用FAX作成に先立ち、以下のチェックを行います。以下に当てはまる場合は作成できません。<br />
<br />
&nbsp;&nbsp;&nbsp;・ステータスが「送信完了（不達あり）」以外<br />
&nbsp;&nbsp;&nbsp;・送信完了後14日を超える案件
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
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/1/retry" \
  -d '' \ 
  -X POST \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id <span class="required">必須</span>|FAXID|数値|再送信したいFAXのID<br/>`/api/v1/facsimiles/:facsimile_id/retry` の形式で指定|



## レスポンス

> ボディ

```json
{
  "facsimile_id": 2,
  "delivery_name": "Fax再送信1_test",
  "notice_mail_addresses": [],
  "print_headers": [],
  "print_line_page": 1,
  "print_line_type": 1,
  "fax_quality": 0,
  "fax_speed": 0,
  "delivery_to_count": 1,
  "delivery_stop_count": 0,
  "allow_international_fax": false,
  "allow_duplicate_fax_numbers": false,
  "retry_no": 1,
  "retry_count": 1,
  "retry_ids": [
    1,
    2
  ],
  "created_at": "2017-09-07T18:44:38+09:00",
  "contact_list_id": null,
  "exclusion_contact_list_ids": [],
  "honorific": 0,
  "bill_split_code": null
}
```
|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|facsimile_id|FAXID|数値|今回作成された再送信用FAXのID|
|delivery_name|案件名|文字列|FAXの案件名<br />「Fax再送信`n`_元FAXの案件名」が自動設定される<br /><br />`n` :再送信回数|
|notice_mail_addresses|通知メール|配列:文字列|完了通知メールの送信先メールアドレスの配列<br>`["〜@example.com","〜@example.com",...]`|
|print_headers| 印字内容 |配列|[]：印字指定なし<br />[文字列]：1行印字<br>[文字列, 文字列, 文字列, 文字列]：4行印字（なお、空行は空文字列で表す）<br><br>以下に宛先リスト(CSV)のヘッダ行（1行目）が「"会社名", "部署名", "役職名", "氏名", "FAX番号"」である場合の各種例を示す<br><br>例1: 原稿への差込先頭行に「会社名」、2行目に「部署名」、3行目に「役職名」、4行目に「氏名」を設定する場合<br>`["{{会社名}}", "{{部署名}}", "{{役職名}}", "{{氏名}}"]`<br><br>例2: 先頭行を「会社名」「部署名」の複数項目とし、2行目は「役職名」、3行目に「氏名」、4行目に「FAX番号」を設定する場合<br>`["{{会社名}} {{部署名}}", "{{役職名}}", "{{氏名}}", "{{FAX番号}}"]`<br><br>例3: 先頭行、2行目と3行目は例2と同じ。4行目を固定文字列 +「FAX番号」に設定する場合<br>`["{{会社名}} {{部署名}}", "{{役職名}}", "{{氏名}}", "ご送付先 {{FAX番号}}"]` |
|print_line_page|印字ページ|数値|`1`:1枚目のみ、`2`:全ページ|
|print_line_type|印字方法|数値|`1`:添付貼付、`2`:透明貼付|
|fax_quality|送信画質|数値|`0`:ノーマル、`1`:ファイン|
|fax_speed|送信速度|数値|`0`:スタンダード、`1`:エコノミー|
|delivery_to_count | 総宛先数 | 数値 | 総宛先数 |
|delivery_stop_count | 除外件数 | 数値 | 除外件数 |
|allow_international_fax | 海外宛先有無 | 真偽値 | `true`:有、`false`:無 |
|allow_duplicate_fax_numbers | 重複宛先を許容する | 真偽値 | `true`:送信対象煮含める、`false`:重複宛先を除外する |
|retry_no | 再送信回数 | 数値 | 何回目の再送信かを表す |
|retry_count | 総再送信回数 | 数値 | 再送信を行った総回数 |
|retry_ids | 再送信FAXID | 配列:数値 | 送信した再送信FAXのIDの配列<br />`[再送信FAXID...]` |
|created_at | 作成日 | 文字列（ISO8601形式）　 | 案件の作成日時 |
|contact_list_id | 宛先リストID | 数値 | 宛先リストID |
|exclusion_contact_list_ids|送信停止リスト|配列:数値|適用した送信停止リストIDの配列<br>`[送信停止リストID...]`|
|honorific|敬称コード|数値|`0`:敬称なし、`1`:様、`2`:殿、`3`:御中、`4`:先生、`5`:各位|
|bill_split_code | 請求明細分割コード | 文字列 | 半角英数字・ハイフン・アンダースコアで20桁以内 |
