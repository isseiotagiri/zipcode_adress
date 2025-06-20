# 07 認証確認

<p style="font-size: 16px; font-weight: bold"><span class="asterisk">※</span>本APIのご利用には別途ご契約が必要です。</p>

> HTTPメソッド及び、URL

```
POST /api/v1/verification_code/verify
```

「05 認証コード生成」で生成、配信したコードの認証確認を行います。<br/>

認証成功した後はコードが無効となります。<br/>
また、同一電話番号で５回連続認証失敗すると、コードが無効となります。


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
  "phone_number": "090xxxxxxxx",
  "verification_code": "135217"
}
```

> サンプルコード

```sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/verification_code/verify" \
  -X POST \
  -d '{"phone_number":"090xxxxxxxx","verification_code":"135217"}' \
  -H "Accept:       application/json" \
  -H "token:        YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

<table>
  <tr>
    <th class="container">項番</th>
    <th class=>物理名</th>
    <th class=>論理名</th>
    <th class=>型</th>
    <th>必須</th>
    <th class=>制約</th>
    <th class=>説明</th>
  </tr>
  <tr>
    <td class="container">1</td>
    <td>phone_number</td>
    <td>電話番号</td>
    <td>文字列</td>
    <td>○</td>
    <td></td>
    <td>認証コードを受信した宛先の電話番号</td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>verification_code</td>
    <td>認証コード</td>
    <td>文字列</td>
    <td>○</td>
    <td></td>
    <td>SMSLINKが配信した認証コード</td>
  </tr>
</table>

## レスポンス

> ボディ

```json
{
  "phone_number": "090xxxxxxxx",
  "verification_code": "135217",
  "verify_result_code": "VRFY00001",
  "verify_result_message": "認証に成功しました。"
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
    <td>phone_number</td>
    <td>電話番号</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>認証コードを受信した宛先の電話番号</td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>verification_code</td>
    <td>認証コード</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>SMSLINKが配信した認証コード</td>
  <tr>
    <td class="container">3</td>
    <td>verify_result_code</td>
    <td>認証結果コード</td>
    <td>文字列</td>
    <td>最大10文字</td>
    <td>認証結果コード・認証結果メッセージ一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">4</td>
    <td>verify_result_message</td>
    <td>認証結果メッセージ</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>認証結果コード・認証結果メッセージ一覧を参照<span class="asterisk">※1</span></td>
  </tr>
</table>
<br/>

<span class="asterisk">※1</span>　認証結果コード・認証結果メッセージ一覧

|verify_result_code|verify_result_message|説明|
| --- | --- | --- |
|VRFY00001|認証に成功しました。||
|VRFY00002|有効期限が切れた為、認証に失敗しました。|指定した認証コードの有効期限が切れています。|
|VRFY00003|コード特定できない為、認証に失敗しました。|指定した認証コードが見つかりません。|
|VRFY00004|既に認証済みの為、認証に失敗しました。|認証成功した後、同一コードで再度認証することはできません。|
|VRFY00005|無効なコードの為、認証に失敗しました。|同一電話番号が５回連続認証失敗すると、コードが無効となります。新しいコードを送ってください。|

<br>
