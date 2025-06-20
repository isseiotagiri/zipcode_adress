# 03-08 FAX原稿登録
> HTTPメソッド及び、URL

```
POST /api/v1/facsimiles/:facsimile_id/contents
```

指定のFAXへFAX原稿を登録します。登録可能なファイル形式は、pdf, doc, docx, xls, xlsx, ppt, pptxです。  

1リクエストにつき1ファイルを登録できますので、同一案件へリクエストを繰り返すことで複数のFAX原稿を登録できます。  
登録したFAX原稿にはIDを付与します。誤登録した場合など、FAX原稿を削除するにはこのFAX原稿IDが必要となります。  

<aside class="notice">
PDF以外の原稿ファイルを指定した場合、PDFへの変換が完了するまでは送信できません。<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;変換結果はFAX取得のPDF変換ステータスで確認できます。
</aside>

<aside class="warning">
登録に先立ち、以下のチェックを行います。以下に当てはまる場合は登録されません。<br />
<br />
&nbsp;&nbsp;&nbsp;・FAX原稿ファイル形式が登録可能な形式ではない<br />
&nbsp;&nbsp;&nbsp;・PDF変換後のFAX原稿ファイルサイズが全原稿ファイル合計で50MBを超えている<br />
&nbsp;&nbsp;&nbsp;・FAX原稿のページサイズがA4もしくはB4で統一されていない
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
------------XnJLe9ZIbbGUYtzPQJ16u1
Content-Disposition: form-data; name="file"; filename="upload_contents.pdf"
Content-Type: application/pdf
Content-Length: 3483

[uploaded data]
------------XnJLe9ZIbbGUYtzPQJ16u1--
```


> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/253/contents" \
  -F 'file=@upload_contents.pdf;type=application/pdf' \
  -X POST \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN"
```

### パラメータ

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|facsimile_id <span class="required">必須</span>|FAXID|数値|原稿と関連づくFAXのIDです。<br />`/api/v1/facsimiles/:facsimile_id/contents` の形式で指定します。|
|file <span class="required">必須</span>|FAX原稿ファイル|ファイル|原稿として登録したいファイルを指定します。<br />なお、ファイル名をContent-Dispositionから取得します<br />添付可能なファイル:pdf, doc, docx, xls, xlsx, ppt, pptx<br/ >併せてtypeも指定してください。<span class="notice">※1</span><br />`'file=@attachment.pdf;type=application/pdf'`の形式で指定します。|

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


## レスポンス

> ボディ

```json
{
  "content_id": 184,
  "facsimile_id": 253
}
```

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
| content_id | FAX原稿ID | 数値 | FAX原稿のID |
| facsimile_id | FAXID | 数値 | FAXのID |

