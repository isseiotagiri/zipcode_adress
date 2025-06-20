# 09 SMS受信一覧取得

> HTTPメソッド及び、URL

```
GET　/api/v1/receptions
```

登録された受信SMSを一覧形式で取得します。

並び順は受信IDの昇順です。
パラメータを指定しない場合、最大1,000件取得します。

1001件以上を取得したい場合には、パラメータ「offset」にて取得開始位置を指定いただき、

結果を複数回取得いただく必要がございます。

（例：2回目の取得は取得開始位置を「1000」に指定する）

※ 受信不可な契約であれば、受信レコードがないため結果が0件となります。

## リクエスト

> ヘッダ

```
Accept:       application/json
token:        YOUR_API_TOKEN
Content-Type: application/json
Host:         sand-api-smslink.nexlink2.jp
```

> Query Parameters

```
occurred_on=2023-12-06
```

> サンプルコード

``` sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/receptions?occurred_on=2023-12-06" \
  -X GET \
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
    <td>noticed</td>
    <td>通知済みフラグ</td>
    <td>真偽値</td>
    <td></td>
    <td></td>
    <td>true:通知済み<br>
        false:未通知<br>
        指定しない場合：両方
    </td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>occurred_on</td>
    <td>受信日</td>
    <td>文字列</td>
    <td></td>
    <td>日付形式</td>
    <td>yyyy-MM-dd形式<br>
        過去35日以内の日付が指定可能です<br>
        指定がない場合は当日となります
    </td>
  </tr>
  <tr>
    <td class="container">3</td>
    <td>offset</td>
    <td>取得開始位置</td>
    <td>数値</td>
    <td></td>
    <td></td>
    <td>取得開始位置を指定する。<br>
        指定しない場合、0となる。</td>
  </tr>
  <tr>
    <td class="container">4</td>
    <td>limit</td>
    <td>取得件数</td>
    <td>数値</td>
    <td></td>
    <td></td>
    <td>取得件数を指定する。<br>
        指定しない場合、1000となる。</td>
  </tr>
</table>

## レスポンス

> ボディ

```json
{
  "total":3,
  "receptions":[
    {
      "reception_id": 8,
      "short_code": "0005xxxx",
      "phone_number": "080xxxxxxxx",
      "carrier": 10,
      "message": "承知いたしました。ご連絡ありがとうございます。",
      "occurred_at": "2018-06-19T16:05:37+09:00",
      "noticed": true
    },
    {
      "reception_id": 3,
      "short_code": "0005xxxx",
      "phone_number": "080xxxxxxxx",
      "carrier": 10,
      "message": "承知いたしました。ご連絡ありがとうございます。",
      "occurred_at": "2018-06-19T16:05:37+09:00",
      "noticed": false
    },
    {
      "reception_id": 1,
      "short_code": "0005xxxx",
      "phone_number": "080xxxxxxxx",
      "carrier": 10,
      "message": "承知いたしました。ご連絡ありがとうございます。",
      "occurred_at": "2018-06-19T16:05:37+09:00",
      "noticed": false
    }
  ]
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
    <td>total</td>
    <td>合計件数</td>
    <td>数値</td>
    <td>最大20桁</td>
    <td></td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>receptions</td>
    <td>受信一覧</td>
    <td>配列</td>
    <td></td>
    <td>受信別情報一覧</td>
  </tr>
  <tr>
    <td class="container">2-1</td>
    <td>reception_id</td>
    <td>受信ID</td>
    <td>数値</td>
    <td>最大20桁</td>
    <td>SMSLINKが発行した受信ID</td>
  </tr>
  <tr>
    <td class="container">2-2</td>
    <td>short_code</td>
    <td>ショートコード</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>SMSの送信先となる番号</td>
  </tr>
  <tr>
    <td class="container">2-3</td>
    <td>phone_number</td>
    <td>携帯電話番号</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>SMSの送信をした携帯電話番号</td>
  </tr>
  <tr>
    <td class="container">2-4</td>
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
    <td class="container">2-5</td>
    <td>message</td>
    <td>本文</td>
    <td>文字列</td>
    <td>最大70文字</td>
    <td></td>
  </tr>
  <tr>
    <td class="container">2-6</td>
    <td>occurred_at</td>
    <td>受信時刻</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>SMSLINKが受信SMSを受け付けた時刻<br>
        （YYYY-MM-DDThh:mm:ss+09:00形式）
    </td>
  </tr>
  <tr>
    <td class="container">2-7</td>
    <td>noticed</td>
    <td>通知済みフラグ</td>
    <td>真偽値</td>
    <td></td>
    <td>true:通知済み<br>
        false:未通知
    </td>
  </tr>
</table>
<br/>
