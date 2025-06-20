# 05 認証コード生成

<p style="font-size: 16px; font-weight: bold"><span class="asterisk">※</span>本APIのご利用には別途ご契約が必要です。</p>

> HTTPメソッド及び、URL

```
POST /api/v1/verification_code/generate_and_delivery
```

認証コードの生成と、SMS・音声通話による配信を行います。<br/>
生成したコードはレスポンス内でお渡しします。<br/>

配信したコードの認証確認を行いたい場合は「07 認証確認」でご確認ください。<br/>

配信結果は「08 配信結果取得」でご確認ください。


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
    "message": "appの認証コード:{{verification_code}}\r\n他人には教えないでください。{{valid_period_min}}分間有効です。",
    "character_type": 10,
    "character_size": 6,
    "valid_period_min": 30
}
```


> サンプルコード

```sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/verification_code/generate_and_delivery" \
  -X POST \
  -d '{"phone_number":"090xxxxxxxx","delivery_type":10,"message":"appの認証コード:{{verification_code}}\r\n他人には教えないでください。{{valid_period_min}}分間有効です。","character_type":10,"character_size":6,"valid_period_min":30}' \
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
    <td>character_type</td>
    <td>認証コード文字種</td>
    <td>数値</td>
    <td>○</td>
    <td></td>
    <td>
      10: 半角数字のみ<br>
      20: 半角英数字（小文字）<br>
    </td>
  </tr>
  <tr>
    <td class="container">5</td>
    <td>character_size</td>
    <td>認証コード文字数</td>
    <td>数値</td>
    <td>○</td>
    <td>4から12までの整数</td>
    <td></td>
  </tr>
  <tr>
    <td class="container">6</td>
    <td>valid_period_min</td>
    <td>有効期限</td>
    <td>数値</td>
    <td>○</td>
    <td>5から60までの整数</td>
    <td>認証コードの有効期限 <span class="asterisk">※5</span> <br/> 単位: 分 <br>
    </td>
  </tr>
</table>

<span class="asterisk">※1</span> 携帯電話番号の仕様は以下になります。

- 070,080,090から始まる11桁の番号。ただし、0800から始まる11桁の番号には配信できません。
- 020から始まる11桁か14桁の番号。ただし、SMS配信のみ、音声配信はできません。
- 先頭に「+81」を指定した場合「0」に変換されます。
- 海外キャリアには配信できません。
- 「‒(ハイフン)」は省略できます。
- 全角数字は半角に変換されます。

<br/>

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
- 本文に{{verification_code}}と{{valid_period_min}}が必須です。
- 携帯に届く本文は差込情報を含めて70文字以下にしてください。
- 以下は本文の一例です。

<p>
　　ーーーーーー<br/>
　　お客様の認証コードは:{{verification_code}}です。<br/>
　　他人には教えないでください。{{valid_period_min}}分間有効です。<br/>
　　ーーーーーー
</p>

<br/>

<span class="asterisk">※4</span> サンプルメッセージ

|項目|内容|
--- | ---
本文|`お客様の認証コードは888888です。NEXWAYアプリに入力してください。このコードは他人には絶対に教えないでください。60分間有効です。`
文字数|70文字
秒数|45秒（1度の通話で最大2回再生します）
音声ファイル|<audio controls alt="認証コード案内.m4a" src="./audios/verify_code_with_period.mp3"></audio>

- 音声による読み上げを行う場合、漢字やアルファベットなど読み方によって通話時間が変化いたします。

<br/>

<span class="asterisk">※5</span> 認証コード有効期限の仕様は以下になります。

- 「送信予定日時+5分」か「送信完了日時」の小さいほうを有効期限のスタート時刻とします。

<br>


## レスポンス

> ボディ

```json
{
  "verification_code_id": 33,
  "accepted_at": "2022-03-02T18:19:02+09:00",
  "phone_number": "090xxxxxxxx",
  "verification_code": "135217",
  "valid_period_min": 30,
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
    <td>SMSLINKが生成した認証コード</td>
  </tr>
  <tr>
    <td class="container">5</td>
    <td>valid_period_min</td>
    <td>有効期限</td>
    <td>数値</td>
    <td>5から60までの整数</td>
    <td>単位: 分</td>
  </tr>
  <tr>
    <td class="container">6</td>
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
