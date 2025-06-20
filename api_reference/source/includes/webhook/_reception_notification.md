# 11 SMS受信通知

> HTTPメソッド及び、URL

```
POST　<貴社指定URL>
```

SMS受信通知を御社で用意されたURLへ送信します。

レスポンスのヘッダーに「Content-Type: application/json」を指定していただく必要がございます。

レスポンスのステータスが200以外、もしくは、レスポンスのボディーが"false"の場合、
5回まで同内容のSMS受信通知の再送を行います。

レスポンスのステータスが200であり、レスポンスのボディーが読み取れない場合は成功扱いで、再送しません。

再送間隔は10分となります。


## リクエスト

> ヘッダ

```
Accept:       application/json
Content-Type: application/json
Host:         <貴社指定サーバ>
```

> ボディ

```json
{
  "reception_id": 1,
  "short_code": "0005xxxx",
  "phone_number": "080xxxxxxxx",
  "carrier": 10,
  "message": "承知いたしました。ご連絡ありがとうございます。",
  "occurred_at": "2018-06-19T16:05:37+09:00"
}

```

> サンプルコード

``` sh
curl <貴社指定サーバ> \
  -X POST \
  -d '{"reception_id": 1, "short_code": "0005xxxx", "phone_number": "080xxxxxxxx", "message": "承知いたしました。ご連絡ありがとうございます。", "occurred_at": "2018-06-19T16:05:37+09:00"}' \
  -H "Content-Type:application/json"
```

### パラメータ

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
    <td>reception_id</td>
    <td>受信ID</td>
    <td>数値</td>
    <td>最大20桁</td>
    <td>SMSLINKが発行した受信ID</td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>short_code</td>
    <td>ショートコード</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>SMSの送信先となる番号</td>
  </tr>
  <tr>
    <td class="container">3</td>
    <td>phone_number</td>
    <td>携帯電話番号</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>SMSの送信をした携帯電話番号</td>
  </tr>
  <tr>
    <td class="container">4</td>
    <td>carrier</td>
    <td>キャリア</td>
    <td>数値</td>
    <td></td>
    <td>SMSの送信をした携帯電話番号のキャリア<br>
        10:docomo<br>
        20:au<br>
        30:softbank<br>
        50:rakuten<br>
    </td>
  </tr>
  <tr>
    <td class="container">5</td>
    <td>message</td>
    <td>本文</td>
    <td>文字列</td>
    <td>最大70文字</td>
    <td></td>
  </tr>
  <tr>
    <td class="container">6</td>
    <td>occurred_at</td>
    <td>受信時刻</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>SMSLINKがSMSを受け付けた時刻<br>
        （YYYY-MM-DDThh:mm:ss+09:00形式）
    </td>
  </tr>
</table>

## レスポンス

> ヘッダ

```
Content-Type: application/json
```

> ボディ

```json
{
  "result": true
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
    <td>result</td>
    <td>結果</td>
    <td>真偽値</td>
    <td></td>
    <td>結果<br/>
        true:受信通知を正常に受信<br/>
        false:受信通知で異常が発生</td>
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
