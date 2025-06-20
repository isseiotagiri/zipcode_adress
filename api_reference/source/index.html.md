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

すべてのAPIアクセスはHTTPS経由で行われ、すべてのデータはJSON形式で受信されます。

<div class="center-column"></div>

```
Accept:        application/json
token:         YOUR_API_TOKEN
Content-Type:  application/json
```

| 項目名 | 説明 |
| ---- | ---- |
| Accept | JSON形式`application/json`を指定します。|
| Token | `YOUR_API_TOKEN`部分を提供されたAPIトークンで置き換えます。<br/>APIトークンはマネージャ権限ユーザーの設定画面よりご確認ください。 |
| Content-Type | JSON形式`application/json`を指定します。|

### レスポンス

すべてのデータはJSON形式で送信されます。

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


| 項目名 | 説明 |
| ---- | ---- |
| Content-Type | JSON形式`application/json`を指定します。|

### 通信方式
本システムは HTTP/1.1 による通信を前提としています。
HTTP/2 での通信は安定しない場合があります。

## 開発環境について

稼働時間は、平日9:00~24:00で稼働しております。   
予期せぬ事態で一時的に利用できない場合がございます。   
利用できない際にはお手数ですが、お問い合わせください。   
お問い合わせ受付時間は平日9:00~17:00となっております。   

※開発環境から実際にSMS送信の配信はできません。   
※稼働時間外のアクセスは、503エラーが表示される可能性があります。   
※短時間での大量入力は行わないようお願いいたします。   
※本番環境と同等のセキュリティは担保されておりません。   
※環境スペック、設定等は本番と異なります。   

## シミュレータ番号一覧

シミュレータ番号宛に配信いただくことで、予め用意された結果を返却します。   
開発環境では実際にSMSを配信することはできませんので 動作確認にはシミュレータ番号をご利用ください。   

※この番号は本番環境では、利用できません。 


<table style="table-layout: fixed;">
  <thead>
    <tr>
      <th>携帯番号</th>
      <th>キャリア</th>
      <th>status</th>
      <th>message</th>
      <th>detail</th>
      <th style="width: 120px">detail_message</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>09001111101</td>
      <td>30:softbank</td>
      <td>200</td>
      <td>配信成功</td>
      <td>DTL000001</td>
      <td>端末への配信に成功</td>
    </tr>
    <tr>
      <td>09001111102</td>
      <td>10:docomo</td>
      <td>200</td>
      <td>配信成功</td>
      <td>DTL000001</td>
      <td>端末への配信に成功</td>
    </tr>
    <tr>
      <td>09001111103</td>
      <td>20:au</td>
      <td>200</td>
      <td>配信成功</td>
      <td>DTL000001</td>
      <td>端末への配信に成功</td>
    </tr>
    <tr>
      <td>09001111104</td>
      <td>50:rakuten</td>
      <td>200</td>
      <td>配信成功</td>
      <td>DTL000001</td>
      <td>端末への配信に成功</td>
    </tr>
    <tr>
      <td>09001111201</td>
      <td>30:softbank</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111202</td>
      <td>10:docomo</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111203</td>
      <td>20:au</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111204</td>
      <td>50:rakuten</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111211</td>
      <td>30:softbank</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111212</td>
      <td>10:docomo</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111213</td>
      <td>20:au</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111221</td>
      <td>30:softbank</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111222</td>
      <td>10:docomo</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111223</td>
      <td>20:au</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111231</td>
      <td>30:softbank</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111232</td>
      <td>10:docomo</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09001111233</td>
      <td>20:au</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000007</td>
      <td>端末が圏外、または電源offの可能性あり</td>
    </tr>
    <tr>
      <td>09002222001</td>
      <td>40:unknown</td>
      <td>900</td>
      <td>配信失敗</td>
      <td>DTL000011</td>
      <td>SMSが受信できない番号の可能性あり</td>
    </tr>
    <tr>
      <td>09007010001 <span class="asterisk">※1</span></td>
      <td>10:docomo</td>
      <td>200</td>
      <td>配信成功</td>
      <td>DTL000001</td>
      <td>端末への配信に成功</td>
    </tr>
    <tr>
      <td>その他 <span class="asterisk">※2</span></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
  </tbody>
</table>

<span class="asterisk">※1</span> 双方向通信を契約している場合にこの番号にSMSを送信するとメッセージが返信されます、`11 SMS受信通知のWebhook`を確認する際にご利用ください <br>
<span class="asterisk">※2</span> その他の番号について配信結果は保証されません

## Windowsからcurlサンプルを実行する場合
各APIに記載しておりますcurlのサンプルは、Windowsではそのまま利用できない場合があります。

例えば、以下のように修正して実行してください。

1. コマンドを複数行に分割して書く場合、行末は `\` の代わりに `^` を使用します。
1. リクエストボディを送信する場合、ボディ全体を `''` の代わりに `""` で囲みます。
1. リクエストボディに` " `が含まれる場合、ダブルクオーテーションを` \ `でエスケープします。
1. リクエストボディに日本語が含まれる場合は、2,3の代わりにリクエストボディだけをテキストファイルにutf-8で保存し、`-d @リクエストファイル名`を指定します。


### SMS配信登録APIの場合、以下のようになります。

<div class="center-column"></div>

```sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/delivery" ^
  -X POST ^
  -d "{\"contacts\":[{\"phone_number\":\"090-0000-0001\"}],\"text_message\":\"test...\",\"reserved_at\":\"\",\"click_count\":true,\"notification_emails\":[]}" ^
  -H "Accept: application/json" ^
  -H "token: YOUR_API_TOKEN" ^
  -H "Content-Type: application/json"
```

### リクエストボディに日本語が含まれる即時配信の場合、以下のようになります。

<div class="center-column"></div>

```sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/delivery" ^
  -X POST ^
  -d @request.json ^
  -H "Accept: application/json" ^
  -H "token: YOUR_API_TOKEN" ^
  -H "Content-Type: application/json"
```

### その際の`request.json`の内容は以下のようになります。

<div class="center-column"></div>

```json
{"contacts":[{"phone_number":"090xxxxxxxx"}],"text_message":" こんにちはここ https://sand-api-smslink.nexlink2.jp をクリックしてください{{配信停止URL}}","reserved_at":"","click_count":true,"notification_emails":["test1@example.com(通知先1)","test2@example.com(通知先2)"]}
```
