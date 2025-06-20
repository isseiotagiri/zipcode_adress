# 03-15 FAX送信結果取得

> HTTPメソッド及び、URL

```
GET /api/v1/facsimiles/:facsimile_id/transmission
```

指定されたFAXの送信結果を取得します。

絞り込み条件としてステータスを指定できます。

## リクエスト

> ヘッダ

```
Authorization: token YOUR_API_TOKEN
Content-Type: application/json
Host: sandbox-hea.nexlink2.jp
```

> Query Parameters

```
status=delivery
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/114497/transmission?status=delivery" \
  -X GET \
  -H "Accept: text/csv" \
  -H "Authorization: token YOUR_API_TOKEN"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id <span class="required">必須</span>|FAXID|数値|送信結果を取得したいFAXのID<br/>`/api/v1/facsimiles/:facsimile_id/transmission` の形式で指定|
|status|ステータス|文字列|指定の値で、取得対象の結果を絞り込む<br/>`delivery`:送達のみ、`non_delivery`:不達のみ、 `error`:エラーのみ<br />未設定の場合は指定なしで取得|

## レスポンス

> ボディ

```csv
メールアドレス,FAX,会社名,部署,役職,姓,名,郵便番号,リザーブ1,リザーブ2,リザーブ3,リザーブ4,リザーブ5,リザーブ6,リザーブ7,リザーブ8,リザーブ9,リザーブ10,リザーブ11,リザーブ12,リザーブ13,リザーブ14,リザーブ15,リザーブ16,リザーブ17,リザーブ18,リザーブ19,リザーブ20,リザーブ21,リザーブ22,リザーブ23,リザーブ24,リザーブ25,リザーブ26,リザーブ27,リザーブ28,リザーブ29,リザーブ30,リザーブ31,リザーブ32,リザーブ33,リザーブ34,リザーブ35,リザーブ36,リザーブ37,リザーブ38,リザーブ39,リザーブ40,リザーブ41,リザーブ42,ステータス,確定日時,送信停止,送信エラー,送信エラー詳細
chelsey.sporer@jasteichmann.org,03-XXXX-XXXX,Mante LLC,enim,est,Zulauf,Eulalia,9211096,voluptas,provident,sit,aliquam,nam,doloremque,molestias,sed,dolor,quas,dolores,alias,iusto,hic,natus,quia,et,aliquid,et,quia,voluptatem,dolor,eligendi,ut,sed,architecto,id,cupiditate,soluta,eaque,aut,eos,explicabo,eos,placeat,aspernatur,ea,eligendi,et,consequatur,sunt,distinctio,不達,,無,,
```

CSVデータ構成（文字コード: CP932）   
レスポンスのheaderは「content-type:text/csv; charset=utf-8」になりますが、bodyは「CP932」になっています。   
そのため、一部のツールでは正しく読み込みできない場合があります。   
その場合は文字コードを「CP932」に指定して読み込みを行ってください。

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
| (宛先リストの項目全て) ||||
| ステータス | - | 文字列 | 送達<br/>不達<br/>エラー<br/>停止リスト案件毎停止に該当するため宛先除外<br/>停止リスト全停止（FAX）に該当するため宛先除外<br/>海外FAX番号に該当するため宛先除外|
| 確定日時<span class="notice">※1 | - | 文字列 | 形式はyyyy-mm-dd hh:mi（yyyy:西暦、mm:月、dd:日、hh:時（24時間表記）、mi:分）<br /><span class="notice">※1: ご希望のお客様にはISO8601形式でのご提供も可能ですのでご連絡ください</span> |
| 送信停止 | - | 文字列 | `有`:送信停止リストに該当した<br/>`無`:送信停止リストに該当していない |
| 送信エラー | - | 文字列 | 送信エラー |
| 送信エラー詳細 | - | 文字列 | 送信エラー詳細 |
