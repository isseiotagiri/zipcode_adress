# 10 SMS配信完了通知

> HTTPメソッド及び、URL

```
POST　<貴社指定URL>
```

SMS配信完了通知を御社で用意されたURLへ送信します。

レスポンスのヘッダーに「Content-Type: application/json」を指定していただく必要がございます。

レスポンスのステータスが200以外、もしくは、レスポンスのボディーが"false"の場合、
5回まで同内容のSMS配信完了通知の再送を行います。

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
  "delivery_id": "fd75dc2503c20bb62902fabbbddf98e3",
  "contact_id": 1
}

```

> サンプルコード

``` sh
curl <貴社指定サーバ> \
  -X POST \
  -d '{"delivery_id": "fd75dc2503c20bb62902fabbbddf98e3","contact_id": 1}' \
  -H "Content-Type:application/json"
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
  <tr>
    <td class="container">2</td>
    <td>contact_id</td>
    <td>宛先ID</td>
    <td>数値</td>
    <td>○</td>
    <td></td>
    <td>SMSLINKが発行した宛先ID</td>
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
        true:完了通知を正常に受信<br/>
        false:完了通知に異常が発生</td>
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
