---
title: API Reference

language_tabs:
  - shell: curl

toc_footers:

search: false
---

# ご利用いただくために

## ヘッダーフィールド

### リクエスト

すべてのAPIアクセスはHTTPS経由で行われ、一部のAPIを除いてすべてのデータはJSON形式で受信されます。

<div class="center-column"></div>

```
  Accept:        application/json
  Authorization: token YOUR_API_TOKEN
  Content-Type:  application/json
```

| 項目名 | 説明 |
| ---- | ---- |
| Accept | 一部のAPIを除いてJSON形式`application/json`を指定します。<br>送信結果、除外宛先取得APIには`text/csv`を指定します。<br>プレビュー取得APIには`image/png`を指定します。 |
| Authorization | `YOUR_API_TOKEN`部分を提供されたAPIトークンで置き換えます。 |
| Content-Type | 一部のAPIを除いてJSON形式`application/json`を指定します。<br>宛先リスト登録、送信停止リスト登録、FAX原稿登録、添付ファイル登録には`multipart/form-data`を指定します。 |

### レスポンス

一部のAPIを除いてすべてのデータはJSON形式で送信されます。

<div class="center-column"></div>

```
Content-Type: application/json; charset=utf-8
  X-UA-Compatible: IE=Edge,chrome=1
  ETag: "a65edc5694cdeea8e5dcc62ca2664147"
  Cache-Control: max-age=0, private, must-revalidate
  X-Request-Id: 143aa032478329ffba39a1114576b79c
  X-Runtime: 0.427694
  Content-Length: 77
```


<div class="center-column"></div>

```
Content-Type: image/png
  Content-Disposition: inline
  Content-Transfer-Encoding: binary
  Cache-Control: private
  X-UA-Compatible: IE=Edge,chrome=1
  ETag: "0070531921a29b1e6d1d37058fc80e8a"
  X-Request-Id: e1e0428181c08a1cb832d57f8be3c69a
  X-Runtime: 1.132636
  Content-Length: 99226
```

| 項目名 | 説明 |
| ---- | ---- |
| Content-Type | 一部のAPIを除いてJSON形式`application/json`を指定します。<br>送信結果、除外宛先取得APIには`text/csv`が指定されます。<br>プレビュー取得APIには`image/png`が指定されます。<br>削除APIには特に指定されません。 |

## 開発環境について

稼働時間は、平日9:00~18:00で稼働しております。  
予期せぬ事態で一時的に利用できない場合がございます。  
利用できない際にはお手数ですが、お問い合わせください。  
お問い合わせ受付時間は平日9:00~17:00となっております。  

※開発環境から実際にFAX・メールの送信はできません。  
※稼働時間外にアクセスした場合、503エラーなどが表示される可能性があります。  
※大量宛先のテスト、短時間での大量入力テストは行わないようお願いいたします。  
※本番環境と同等のセキュリティは担保されておりません。  
※環境スペック、設定等は本番と異なります。


## シミュレータFAX番号一覧

シミュレータFAX番号宛に送信いただくことで、予め用意された結果を返却します。<br>
開発環境では実際にFAXを送信することはできません。（通知メールなども送られません)<br>
ステータス動作確認には以下のシミュレータ番号をご利用ください。

※この番号は本番環境では、利用できません。

<table style="table-layout: fixed;">
  <thead>
    <tr>
      <th>FAX番号</th>
      <th>ステータス</th>
      <th>確定日時</th>
      <th>送信停止</th>
      <th>送信エラー</th>
      <th style="width: 120px">送信エラー詳細</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>0100001000</td>
      <td>送達</td>
      <td>yyyy-mm-dd hh:mi</td>
      <td>無</td>
      <td>送達</td>
      <td>ー</td>
    </tr>
    <tr>
      <td>01300000000</td>
      <td>送達</td>
      <td>yyyy-mm-dd hh:mi</td>
      <td>無</td>
      <td>送達</td>
      <td>ー</td>
    </tr>
    <tr>
      <td>0100002000</td>
      <td>不達</td>
      <td>yyyy-mm-dd hh:mi</td>
      <td>無</td>
      <td>不達</td>
      <td>話中</td>
    </tr>
    <tr>
      <td>01300001000</td>
      <td>不達</td>
      <td>yyyy-mm-dd hh:mi</td>
      <td>無</td>
      <td>不達</td>
      <td>話中</td>
    </tr>
    <tr>
      <td>0100004000</td>
      <td>エラー</td>
      <td>yyyy-mm-dd hh:mi</td>
      <td>無</td>
      <td>不達</td>
      <td>通信エラー</td>
    </tr>
    <tr>
      <td>01300003000</td>
      <td>エラー</td>
      <td>yyyy-mm-dd hh:mi</td>
      <td>無</td>
      <td>不達</td>
      <td>通信エラー</td>
    </tr>
    <tr>
      <td>0311111111</td>
      <td>エラー</td>
      <td>yyyy-mm-dd hh:mi</td>
      <td>無</td>
      <td>送信エラー</td>
      <td>迷惑FAX停止</td>
    </tr>
    <tr>
      <td>01309999999</td>
      <td>エラー</td>
      <td>yyyy-mm-dd hh:mi</td>
      <td>無</td>
      <td>送信エラー</td>
      <td>迷惑FAX停止</td>
    </tr>
  </tbody>
</table>

## Windowsからcurlサンプルを実行する場合
各APIに記載しておりますcurlのサンプルは、Windowsではそのまま利用できない場合があります。

例えば、以下のように修正して実行してください

1. コマンドを複数行に分割して書く場合、行末は `\` の代わりに `^` を使用します。
2. リクエストボディを送信する場合、ボディ全体を `''` の代わりに `""` で囲みます。
3. リクエストボディに` " `が含まれる場合、ダブルクオーテーションを` \ `でエスケープします。
4. リクエストボディに日本語が含まれる場合は、2,3の代わりにリクエストボディだけをテキストファイルにutf-8で保存し、`-d @リクエストファイル名`を指定します。


### メール送信APIの場合、以下のようになります。

<div class="center-column"></div>

```sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/88/transmission" ^
  -X POST ^
  -d "{\"scheduled_at\":\"2018-12-21T19:00:00+09:00\", \"use_reservation_notice\":true}" ^
  -H "Accept: application/json" ^
  -H "Authorization: token YOUR_API_TOKEN" ^
  -H "Content-Type: application/json"
```

### リクエストボディに日本語が含まれるメール新規作成の場合、以下のようになります。

<div class="center-column"></div>

```sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails" ^
  -d @request.json ^
  -X POST ^
  -H "Accept: application/json" ^
  -H "Authorization: token YOUR_API_TOKEN" ^
  -H "Content-Type: application/json"
```

#### その際の`request.json`の内容は以下のようになります。

<div class="center-column"></div>

```json
{"contact_list_id":7,"delivery_name":"APIテスト","from_name":"差出人","from_address":"from@example.com","reply_to_address":"reply@example.com","subject":"APIテストタイトル","email_type":1,"text_body":"{{会社}}　{{部署}} \n{{姓}}　{{名}}様\nこんにちは\nここhttps://sandbox-hea.nexlink2.jp/api/v1/referencesをクリックしてください。\nこちらもご確認ください。\n{{添付ファイル名1}}({{添付ファイルURL1}})","allow_duplicate_email_addresses":false,"click_log_urls":["https://sandbox-hea.nexlink2.jp/api/v1/references"],"use_beacon":true,"notice_mail_addresses":["notice@example.com"]}
```
