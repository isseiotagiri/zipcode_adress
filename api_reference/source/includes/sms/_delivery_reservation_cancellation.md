# 03 SMS配信予約キャンセル

> HTTPメソッド及び、URL

```
POST　/api/v1/delivery/cancel
```

予約されたSMS配信をキャンセルします。

配信IDで指定した全宛先への配信がキャンセルされます。

なお、キャンセル受付可能な時間は配信予定日時の10分前までとなります。

## リクエスト

> ヘッダ

```
Accept:       application/json
token:        YOUR_API_TOKEN
Content-Type: application/json
Host:         sand-api-smslink.nexlink2.jp
```

> ボディ

```json
{
  "delivery_id": "fd75dc2503c20bb62902fabbbddf98e3"
}
```

> サンプルコード

``` sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/delivery/cancel" \
  -X POST \
  -d '{"delivery_id":"fd75dc2503c20bb62902fabbbddf98e3"}' \
  -H "Accept:       application/json" \
  -H "token:        YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

<table>
  <tr>
    <th class="container">項番</th>
    <th>物理名</th>
    <th>論理名</th>
    <th>型</th>
    <th>必須</th>
    <th>制約</th>
    <th>説明</th>
  </tr>
  <tr>
    <td class="container">1</td>
    <td>delivery_id</td>
    <td>配信ID</td>
    <td>文字列</td>
    <td>○</td>
    <td></td>
    <td>SMSLINKが発行した配信ID</td>
  </tr>
</table>

## レスポンス

> ボディ

```json
{
  "delivery_id": "fd75dc2503c20bb62902fabbbddf98e3",
  "canceled_at": "2018-06-07T14:33:29+09:00"
}
```

<table>
  <tr>
    <th class="container">項番</th>
    <th>物理名</th>
    <th>論理名</th>
    <th>型</th>
    <th>制約</th>
    <th>説明</th>
  </tr>
  <tr>
    <td class="container">1</td>
    <td>delivery_id</td>
    <td>配信ID</td>
    <td>文字列</td>
    <td></td>
    <td>SMSLINKが発行した配信ID</td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>canceled_at</td>
    <td>キャンセル日時</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>キャンセル日時（YYYY-MM-DDThh:mm:ss+09:00形式）</td>
  </tr>
</table>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
