# 04-05 メール添付ファイル登録
> HTTPメソッド及び、URL

```
POST /api/v1/emails/:email_id/attachments
```

指定のメールへ添付ファイルを登録します。登録可能なファイル形式は、Word（doc、docx）、Excel（xls、xlsx）、PowerPoint（ppt、pptx）、PDFファイル（pdf）、圧縮ファイル（zip、lzh）、テキストファイル（txt）、画像ファイル（jpg、jpeg、png）です。


<aside class="notice">
添付ファイル登録する前に、メール本文に差込項目が設定されている必要があります。
</aside>

1リクエストにつき1ファイルを登録できますので、同一案件へリクエストを繰り返すことで複数の添付ファイルを登録できます。
登録した添付ファイルにはIDを付与します。誤登録した場合など、添付ファイルを削除するにはこの添付ファイルIDが必要となります。


<aside class="warning">
登録に先立ち、以下のチェックを行います。以下に当てはまる場合は登録されません。<br />
<br />
&nbsp;&nbsp;&nbsp;・指定されたメールが編集中以外の場合<br />
&nbsp;&nbsp;&nbsp;・添付ファイルのファイル形式が登録可能な形式ではない<br />
&nbsp;&nbsp;&nbsp;・添付ファイルの合計サイズが50MBを超えている<br />
&nbsp;&nbsp;&nbsp;・添付ファイルの合計ファイル数が10ファイルを超えている<br />
&nbsp;&nbsp;&nbsp;・添付ファイル名が100文字を超えている<br />
&nbsp;&nbsp;&nbsp;・添付ファイル名に環境依存文字が含まれている<br />
&nbsp;&nbsp;&nbsp;・メール本文内の添付ファイル差し込み項目数より添付ファイル数が多い<br />
&nbsp;&nbsp;&nbsp;・添付ファイルにウイルスが含まれていると判断される
</aside>
  
## リクエスト

> ヘッダ

```
Accept: application/json
Authorization: token YOUR_API_TOKEN
Content-Type: multipart/form-data; boundary=----------XnJLe9ZIbbGUYtzPQJ16u1
Host: sandbox-hea.nexlink2.jp
Cookie: 
Origin:
```

> ボディ

```
--------------------------XnJLe9ZIbbGUYtzPQJ16u1
Content-Disposition: form-data; name="file"; filename="attachment.pdf"
Content-Type: application/pdf
[uploaded data]
--------------------------XnJLe9ZIbbGUYtzPQJ16u1--
 
--------------------------XnJLe9ZIbbGUYtzPQJ16u1
Content-Disposition: form-data; name="use_click_log"
 
 true
--------------------------XnJLe9ZIbbGUYtzPQJ16u1--
```


> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/253/attachments" \
  -F 'file=@attachment.pdf;type=application/pdf' \
  -F 'use_click_log=true' \
  -X POST \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN"
```

### パラメータ

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|email_id <span class="required">必須</span>|メールID|数値|添付を登録するメールのIDです。<br />_`/api/v1/emails/:email_id/attachments` の形式で指定します。_|
|file <span class="required">必須</span>|添付ファイル|ファイル|添付したいファイルを指定します。<br />添付可能なファイル:pdf xls xlsx doc docx ppt pptx zip lzh txt jpg jpeg png<br/ >併せてtypeも指定してください。<span class="notice">※1</span><br />`'file=@attachment.pdf;type=application/pdf'`の形式で指定します。|
|use_click_log|クリックログ使用有無|真偽値|`true`: 使用する、`false`: 使用しない<br>未設定の場合は`false`|

### <span class="notice">※1</span> type一覧

拡張子| type
--- | ---
pdf|application/pdf
xls|application/vnd.ms-excel
xlsx|application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
doc|application/msword
docx|application/vnd.openxmlformats-officedocument.wordprocessingml.document
ppt|application/vnd.ms-powerpoint
pptx|application/vnd.openxmlformats-officedocument.presentationml.presentation
zip|application/zip
lzh|application/lha
txt|text/plain
jpg jpeg|image/jpeg
png|image/png

## レスポンス

> ボディ

```json
{
  "email_id": 253,
  "attachment_id": 76,
  "file_name": "attachment.pdf",
  "url": "https://dl.sandbox-hea.nexlink2.jp/email_attachments/6f324e55-4f0b-4e7f-a7e6-09c5f58ea00d",
  "file_type": "PDF",
  "file_size": 58,
  "use_click_log": true
}
```

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
| email_id | メールID | 数値 | メールのID |
| attachment_id | 添付ファイルID | 数値 | 添付ファイルのID |
| file_name | 添付ファイル名 | 文字列 | 添付ファイル名 |
| url | 添付ファイルのURL | 文字列 | 添付ファイルのURL |
| file_type | 添付ファイルの形式 | 文字列 | 添付ファイルの拡張子の大文字表記(PNGなど) |
| file_size | 添付ファイルのサイズ | 数値 | 添付ファイルのサイズ<br>単位は`KB` |
| use_click_log | クリックログ使用有無 |真偽値 |`true`: 使用する、`false`: 使用しない|
