# 03-17 FAX除外宛先取得

> HTTPメソッド及び、URL

```
GET /api/v1/facsimiles/:facsimile_id/contacts/exclusions
```

指定されたFAXに対して除外宛先がないかチェックを行い、除外となる宛先を理由と共にCSVデータ形式で取得します。  
FAX送信指示の前に本APIを実施することで、事前に除外宛先の存在を知ることができます。

<aside class="notice">
取得できる除外宛先は以下になります<br />
<br />
&nbsp;&nbsp;&nbsp;・宛先印字の結果、最大長を超過してしまう（FAXのallow_excess_print_contactが未設定かfalseで設定されている場合）<br />
&nbsp;&nbsp;&nbsp;・宛先リストに海外宛先が含まれているが、FAXに海外宛先なしと指定されている場合<br />
&nbsp;&nbsp;&nbsp;・送信停止リストに合致する宛先が含まれている場合
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
curl "https://sandbox-hea.nexlink2.jp/api/v1/facsimiles/219/contacts/exclusions" \
  -X GET \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: text/csv"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|facsimile_id <span class="required">必須</span>|FAXID|数値|除外宛先の取得対象となるFAXのID<br/>`/api/v1/facsimiles/:facsimile_id/contacts/exclusions ` の形式で指定|


## レスポンス

> ボディ

```csv
会社,部署,姓,名,メール,FAX,日付,説明,郵便番号,都道府県,市区,一行印字,ステータス,確定日時,送信停止,送信エラー,送信エラー詳細
株式会社A,情報推進グループ,山田,次郎,test@example.com,03-XXXX-XXXX,2013/1/22,送信,101-0043,東京都,港区,"",エラー,,無,印字情報の文字数超過により送信不可,
株式会社D,情報推進グループ,大和,太郎,test_d@example.com,03-XXXX-XXXX,2013/1/22,送信,101-0043,東京都,港区,"",送信停止リストに該当するため宛先除外,,有,,
株式会社E,情報推進グループ,大和,太郎,test_e@example.com,03-XXXX-XXXX,平成21年3月21日,送信,101-0043,東京都,港区,"",海外FAX番号に該当するため宛先除外,,有,海外FAX番号のため、送信不可,
```

CSVデータ構成（文字コード: CP932）   
レスポンスのheaderは「content-type:text/csv; charset=utf-8」になりますが、bodyは「CP932」になっています。   
そのため、一部のツールでは正しく読み込みできない場合があります。   
その場合は文字コードを「CP932」に指定して読み込みを行ってください。

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
| (宛先リストの項目全て) ||||
| ステータス | - | 文字列 | 送信予約中<br/>送信準備中<br/>送信準備完了<br/>送信中<br/>送信済み（結果確認中）<br/>送信完了<br/>送信完了（エラーあり） |
| 確定日時 | - | 文字列（ISO8601形式） | 確定日時 |
| 送信停止 | - | 文字列 | `有`:送信停止リストに該当した<br/>`無`:送信停止リストに該当していない |
| 送信エラー | - | 文字列 | 送信エラー |
| 送信エラー詳細 | - | 文字列 | 送信エラー詳細 |
