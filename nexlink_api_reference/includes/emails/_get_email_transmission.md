# 04-11 メール送信結果取得

> HTTPメソッド及び、URL

```
GET /api/v1/emails/:email_id/transmission
```

指定されたメールの送信結果を取得します。

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
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/113/transmission?status=delivery" \
  -X GET \
  -H "Accept: text/csv" \
  -H "Authorization: token YOUR_API_TOKEN"
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|email_id <span class="required">必須</span>|メールID|数値|送信結果を取得したいメールのID<br/>`/api/v1/emails/:email_id/transmission` の形式で指定|
|status|ステータス|文字列|指定の値で、取得対象の結果を絞り込む<br/>`delivery`:送信済み（結果確認中）または送信完了のみ、`error`:エラーのみ<br />未設定の場合は指定なしで取得|

## レスポンス

> ボディ

```csv
会社,部署,姓,名,メールアドレス,FAX,ステータス,確定日時,ステータス詳細,送信停止,開封ログ,https://sandbox-hea.nexlink2.jp/api/v1/references,添付ファイル(M_1.PDF)
株式会社A,情報推進グループ,大和,太郎,test1@example.com,9999999999,送信完了,2018-12-25 13:18,,無,無,無,無
株式会社B,情報推進グループ,山田,太郎,test2@example.com,9999999999,送信完了,2018-12-25 13:18,,無,無,無,無
株式会社C,情報推進グループ,山田,次郎,test3@example.com,9999999999,送信完了,2018-12-25 13:18,,無,無,無,無
株式会社D,情報推進グループ,大和,次郎,test4@example.com,9999999999,送信完了,2018-12-25 13:18,,無,無,無,無
株式会社E,情報推進グループ,大和,三郎,test5@example.com,9999999999,送信完了,2018-12-25 13:18,,無,無,無,無

```

CSVデータ構成（文字コード: CP932）

|物理名|論理名|型|説明|
| --- | --- | --- | --- |
| (宛先リストの項目全て) ||||
| ステータス | - | 文字列 | 送信予約中<br/>送信準備中<br/>送信準備完了<br/>送信中<br/>送信済み（結果確認中）<br/>送信完了<br/>エラー<br/>停止リスト案件毎停止に該当するため宛先除外<br/>停止リスト全停止（メール）に該当するため宛先除外<br/>メールシステムのポリシー違反に該当するため宛先除外<br/>差し込み項目不正 |
| 確定日時 | - | 文字列 | 形式はyyyy-mm-dd hh:mi（yyyy:西暦、mm:月、dd:日、hh:時（24時間表記）、mi:分） |
| ステータス詳細 | - | 文字列 | ステータス詳細 |
| 送信停止 | - | 文字列 | "有": 送信停止URLがクリックされた<br/>"無": 送信停止URLがクリックされていない |
| 開封ログ | - | 文字列 | "有": メールが開封された<br/>"無": メールが開封されていない |
| URL　または　添付ファイル(添付ファイル名)<span class="notice">*</span> | - | 文字列 | "有": URLがクリックされた<br/>"無": URLがクリックされていない<br><br><span class="notice">*1: click_log_urlを指定している場合、添付ファイルのuse_click_logをtrueに指定している場合に、指定した数だけ列が追加されます。</span><br><br>例) click_log_urlsに`https://hoge.com`が設定されていて、かつクリックログ設定されている添付ファイルが１個ある状態で、一行目の宛先ユーザが添付ファイルURLのみクリックしている場合<br><br>`〜, https://hoge.com, 添付ファイル(添付ファイル名)`<br>`〜, 無, 有`|
