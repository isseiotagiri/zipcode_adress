# 08 配信結果取得

<p style="font-size: 16px; font-weight: bold"><span class="asterisk">※</span>本APIのご利用には別途ご契約が必要です。</p>

> HTTPメソッド及び、URL

```
GET /api/v1/verification_code/delivery_result
```

認証コードの配信結果を取得します。


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
verification_code_id=3
```

> サンプルコード

```sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/verification_code/delivery_result?verification_code_id=3" \
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
    <td>verification_code_id</td>
    <td>認証コードID</td>
    <td>数値</td>
    <td>○</td>
    <td></td>
    <td>SMSLINKが発行した認証コードID</td>
  </tr>
</table>


## レスポンス

> ボディ

```json
{
  "verification_code_id": 3,
  "phone_number": "090xxxxxxxx",
  "delivery_type": 30,
  "sms_result": {
    "delivered_at": "2022-03-02T18:20:05+09:00",
    "status": 900,
    "message": "配信失敗",
    "detail": "DTL000011",
    "detail_message": "SMSが受信できない番号の可能性あり",
    "carrier": 40,
    "transmission_count": null
  },
  "voice_result": {
    "delivered_at": "2022-03-02T18:20:45+09:00",
    "status": 200,
    "message": "送達",
    "detail": "DTL000001",
    "detail_message": "端末への配信に成功",
    "call_time_minute": 1
  }
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
    <td>phone_number</td>
    <td>電話番号</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>認証コードを配信した宛先の電話番号</td>
  </tr>
  <tr>
    <td class="container">3</td>
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
  <tr>
    <td class="container">4</td>
    <td>sms_result</td>
    <td>SMS配信結果</td>
    <td>オブジェクト</td>
    <td></td>
    <td>配信方法が「20: 音声」の場合、nullとなる</td>
  </tr>
  <tr>
    <td class="container">4-1</td>
    <td>delivered_at</td>
    <td>配信完了日時</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>配信の完了日時（YYYY-MM-DDThh:mm:ss+09:00形式）</td>
  </tr>
  <tr>
    <td class="container">4-2</td>
    <td>status</td>
    <td>結果ステータス</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>ステータス一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">4-3</td>
    <td>message</td>
    <td>結果メッセージ</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>ステータス一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">4-4</td>
    <td>detail</td>
    <td>結果詳細ステータス</td>
    <td>文字列</td>
    <td>最大10文字</td>
    <td>ステータス一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">4-5</td>
    <td>detail_message</td>
    <td>結果詳細メッセージ</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>ステータス一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">4-6</td>
    <td>carrier</td>
    <td>キャリア</td>
    <td>数値</td>
    <td></td>
    <td>配信した携帯電話番号のキャリア<br>
        10:docomo<br>
        20:au<br>
        30:softbank<br>
        40:unknown<br>
        50:rakuten<br>
        SMSで配信した場合、上記のいずれかを返す。
    </td>
  </tr>
  <tr>
    <td class="container">4-7</td>
    <td>transmission_count</td>
    <td>通数</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>配信したSMSの通数<br>
    </td>
  </tr>
  <tr>
    <td class="container">5</td>
    <td>voice_result</td>
    <td>音声配信結果</td>
    <td>オブジェクト</td>
    <td></td>
    <td>配信方法が「10: SMS」の場合、nullとなる</td>
  </tr>
  <tr>
    <td class="container">5-1</td>
    <td>delivered_at</td>
    <td>配信完了日時</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>配信の完了日時（YYYY-MM-DDThh:mm:ss+09:00形式）</td>
  </tr>
  <tr>
    <td class="container">5-2</td>
    <td>status</td>
    <td>結果ステータス</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>ステータス一覧を参照<span class="asterisk">※2</span></td>
  </tr>
  <tr>
    <td class="container">5-3</td>
    <td>message</td>
    <td>結果メッセージ</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>ステータス一覧を参照<span class="asterisk">※2</span></td>
  </tr>
  <tr>
    <td class="container">5-4</td>
    <td>detail</td>
    <td>結果詳細ステータス</td>
    <td>文字列</td>
    <td>最大10文字</td>
    <td>ステータス一覧を参照<span class="asterisk">※2</span></td>
  </tr>
  <tr>
    <td class="container">5-5</td>
    <td>detail_message</td>
    <td>結果詳細メッセージ</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>ステータス一覧を参照<span class="asterisk">※2</span></td>
  </tr>
  <tr>
    <td class="container">5-6</td>
    <td>call_time_minute</td>
    <td>通話時間</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>単位: 分<span class="asterisk">※3</span><br>
    </td>
  </tr>
</table>
<br/>

<span class="asterisk">※1</span>SMS配信結果のステータス一覧

|status|message|detail|detail_message|説明|
| --- | --- | --- | --- | --- |
|0|配信待ち| | |配信待ちのステータスです<br>detailとdetail_messageはnullです|
|100|配信中| | |配信中のステータスです<br>detailとdetail_messageはnullです|
|200|配信成功|DTL000001|端末への配信に成功|正常に配信されたステータスです|
|300|配信不要|DTL000024|端末への配信は既に成功したため、リトライ不要|音声で正常に配信されたため、SMSは配信されませんでした|
|700|配信不可|DTL000005|配信不可な携帯電話番号の為、配信対象に登録できませんでした。|携帯電話番号の形式ではないため除外されました|
|900|配信失敗|DTL000006|キャリア配信に失敗しました| キャリア側の都合で配信に失敗しました|
|900|配信失敗|DTL000007|端末が圏外、または電源offの可能性あり|端末が圏外か電源offの可能性がある為配信に失敗しました|
|900|配信失敗|DTL000011|SMSが受信できない番号の可能性あり|SMSが受信できない番号の可能性があるため配信に失敗しました|
|900|配信失敗|DTL000017|携帯電話番号が配信停止番号に登録されているため、配信できませんでした|携帯電話番号が配信停止番号に登録されています|

<br/>

<span class="asterisk">※2</span>音声配信結果のステータス一覧

|status|message|detail|detail_message|説明|
| --- | --- | --- | --- | --- |
|0|配信待ち| | |配信待ちのステータスです<br>detailとdetail_messageはnullです|
|100|配信中| | |配信中のステータスです<br>detailとdetail_messageはnullです|
|200|配信成功|DTL000001|端末への配信に成功|正常に配信されたステータスです|
|300|配信不要|DTL000024|端末への配信は既に成功したため、リトライ不要|SMSで正常に配信されたため、音声は配信されませんでした|
|700|配信不可|DTL000022|通話不可な電話番号の為、配信対象に登録できませんでした。| 通話可能な電話番号ではないため除外されました|
|900|配信失敗|DTL000017|携帯電話番号が配信停止番号に登録されているため、配信できませんでした|携帯電話番号が配信停止番号に登録されています|
|900|配信失敗|DTL000023|音声配信に失敗しました。| 音声システムの都合で配信できませんでした|

<br>

<span class="asterisk">※3</span> 通話時間の仕様は以下になります。

- 音声システムの都合上、コール音が鳴ったタイミングから通話時間をカウントし始めます。<br/>
  実際の音声が流れる時間とは異なりますので、ご了承ください。
- 課金単位未満の音声通話は切り上げ計算となります。<br/>
（例）1分1秒 ⇒ 2分として計算

<br/>
