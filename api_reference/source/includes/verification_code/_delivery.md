# 06 認証コード生成なし

<p style="font-size: 16px; font-weight: bold"><span class="asterisk">※</span>本APIのご利用には別途ご契約が必要です。</p>

> HTTPメソッド及び、URL

```
POST /api/v1/verification_code/delivery
```

指定したメッセージを、SMS・音声通話を利用し配信します。<br>
配信結果は「08 配信結果取得」でご確認ください。<br>

音声通話で配信した場合、アルファベットの大文字/小文字は区別ができないため、混在しないようご注意ください。<br>
また、記号も発音できないため、認証コードとして利用しないようご注意ください。


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
  "delivery_type": 10,
  "message": "appの認証コード:{{verification_code}}\r\n他人には教えないでください。5分間有効です。",
  "verification_code": "sfas33"
}
```


> サンプルコード

```sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/verification_code/delivery" \
  -X POST \
  -d '{"phone_number":"090xxxxxxxx","delivery_type":10,"message":"appの認証コード:{{verification_code}}\r\n他人には教えないでください。5分間有効です。","verification_code":"sfas33"}' \
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
    <td>認証コードを送りたい宛先の電話番号<span class="asterisk">※1</span><span class="asterisk">※2</span></td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>delivery_type</td>
    <td>配信方法</td>
    <td>数値</td>
    <td>○</td>
    <td></td>
    <td>
      10: SMS <br>
      20: 音声 <br>
      30: SMS、音声（SMS不達の場合、音声でリトライ） <br>
      40: 音声、SMS（音声で繋がらない場合、SMSでリトライ） <br>
    </td>
  </tr>
  <tr>
    <td class="container">3</td>
    <td>message</td>
    <td>本文</td>
    <td>文字列</td>
    <td>○</td>
    <td></td>
    <td>配信の本文<span class="asterisk">※3※4</span></td>
  </tr>
  <tr>
    <td class="container">4</td>
    <td>verification_code</td>
    <td>認証コード</td>
    <td>文字列</td>
    <td>○</td>
    <td>最大255文字</td>
    <td></td>
  </tr>
</table>

<span class="asterisk">※1</span> 携帯電話番号の仕様は以下になります。

- 070,080,090から始まる11桁の番号。ただし、0800から始まる11桁の番号には配信できません。
- 020から始まる11桁か14桁の番号。ただし、SMS配信のみ、音声配信はできません。
- 先頭に「+81」を指定した場合「0」に変換されます。
- 海外キャリアには配信できません。
- 「‒(ハイフン)」は省略できます。
- 全角数字は半角に変換されます。

<br>

<span class="asterisk">※2</span> 固定電話番号の仕様は以下になります。

- 050から始まる11桁の番号。ただし、音声配信のみ、SMSは配信できません。
- 0から始まる10桁の番号。ただし、音声配信のみ、SMSは配信できません。
- 0120と0570から始まる10桁の番号はフリーダイヤルであるため、音声もSMSも配信できません。
- 先頭に「+81」を指定した場合「0」に変換されます。
- 海外キャリアには配信できません。
- 「‒(ハイフン)」は省略できます。
- 全角数字は半角に変換されます。

<br>

<span class="asterisk">※3</span> 本文の仕様は以下になります。

- メッセージ本文をUTF-8エンコードにて設定してください。
- 4バイト文字は使用できません。
- 改行コードは全てCRLFに変換され、2文字でカウントされます。
- 本文に{{verification_code}}が必須です。
- 携帯に届く本文は差込情報を含めて70文字以下にしてください。
- 以下は本文の一例です。

<p>
　　ーーーーーー<br/>
　　お客様の認証コードは:{{verification_code}}です。<br/>
　　他人には教えないでください。<br/>
　　ーーーーーー
</p>

<br>

<span class="asterisk">※4</span> サンプルメッセージ

|項目|内容|
--- | ---
本文|`お客様の認証コードは888888です。NEXWAYアプリに入力してください。このコードは他人には絶対に教えないでください。`
文字数|61文字
秒数|37秒（1度の通話で最大2回再生します）
音声ファイル|<audio controls alt="認証コード案内.m4a" src="./audios/verify_code.mp3"></audio>

- 音声による読み上げを行う場合、漢字やアルファベットなど読み方によって通話時間が変化いたします。

## レスポンス

> ボディ

```json
{
  "verification_code_id": 34,
  "accepted_at": "2022-03-02T18:23:24+09:00",
  "phone_number": "090xxxxxxxx",
  "verification_code": "sfas33",
  "delivery_type": 10
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
    <td>verification_code_id</td>
    <td>認証コードID</td>
    <td>数値</td>
    <td>最大20桁</td>
    <td>SMSLINKが発行した認証コードID</td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>accepted_at</td>
    <td>受付日時</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>受付日時（YYYY-MM-DDThh:mm:ss+09:00形式）</td>
  </tr>
  <tr>
    <td class="container">3</td>
    <td>phone_number</td>
    <td>電話番号</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>認証コードを送りたい宛先の電話番号</td>
  </tr>
  <tr>
    <td class="container">4</td>
    <td>verification_code</td>
    <td>認証コード</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>リクエストで渡された認証コード</td>
  </tr>
  <tr>
    <td class="container">5</td>
    <td>delivery_type</td>
    <td>配信方法</td>
    <td>数値</td>
    <td></td>
    <td>
      10: SMS <br>
      20: 音声 <br>
      30: SMS、音声（SMS不達の場合、音声でリトライ） <br>
      40: 音声、SMS（音声で繋がらない場合、SMSでリトライ） <br>
    </td>
  </tr>
</table>
<br/>
