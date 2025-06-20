# 04-08 メール送信

> HTTPメソッド及び、URL

```
POST /api/v1/emails/:email_id/transmission
```

指定したメールの送信を行います。  
時刻指定をすることで送信予約が可能です。時刻指定のない場合は、「最短で送信」での取り扱いとなります。  
また、送信予約完了通知を指定すると、メール作成時に設定した通知メールアドレス宛に予約を完了した旨を通知することができます。

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
  "scheduled_at":"2018-12-21T19:00:00+09:00", 
  "use_reservation_notice":true
}
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/emails/88/transmission" \
  -X POST \
  -d '{"scheduled_at":"2018-12-21T19:00:00+09:00", "use_reservation_notice":true}' \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json" 
```

### パラメータ

| 物理名               | 論理名       | 型     | 説明     |
|----------------------|--------------|--------|----------|
|email_id <span class="required">必須</span>|メールID|数値|送信したいメールのID<br>`/api/v1/emails/:email_id/transmission`の形式で指定|
|scheduled_at <span class="notice">※1</span>|送信予約時刻|文字列（ISO8601形式）|未設定の場合は最短で送信されます。<br> <span class="notice">※1: 送信予約完了通知が通知ありの場合のみ必須<br />過去の時刻または1年より先の時刻は指定できません。<br>10分未満の時刻は切り上げて（+10分として）10分刻みの指定として扱います。</span>|
|use_reservation_notice <span class="notice">※2</span>| 送信予約完了通知 |真偽値|予約完了した時にも、通知メールを送信するかを指定します。<br><br>`true`: 送信予約完了通知あり、`false`: 通知なし<br>未設定の場合は`false`<br><br><span class="notice">※2: 送信予約対象となるメールに、通知メールアドレスが設定されている必要があります。<br>|






## レスポンス

> ボディ

```json
{
  "scheduled_at": "2018-12-21T19:00:00+09:00",
  "email_id": 88
}
```
|物理名|論理名|型|説明|
| --- | --- | --- | --- |
|scheduled_at|送信予定の日時|文字列（ISO8601形式）|送信予定の日時|
|email_id|送信されるメールのID|数値|送信されるメールのID|
