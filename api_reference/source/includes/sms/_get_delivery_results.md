# 04 SMS配信結果取得

> HTTPメソッド及び、URL

```
GET　/api/v1/delivery_results
```

登録されたSMS配信の結果を一覧形式で取得します。

パラメータを指定しない場合、最大1万宛先の配信結果を取得します。

10001件以上を取得したい場合には、パラメータ「offset」にて取得開始位置を指定いただき、

結果を複数回取得いただく必要がございます。

（例：2回目の取得は取得開始位置を「10000」に指定する）


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
limit=3
```

> サンプルコード

``` sh
curl "https://sand-api-smslink.nexlink2.jp/api/v1/delivery_results?limit=3" \
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
    <td>delivery_id</td>
    <td>配信ID</td>
    <td>配列：文字列</td>
    <td></td>
    <td></td>
    <td>SMSLINKが発行した配信ID</br>
        配列に指定する値は50件以内にしてください。</br>
        50件を超えるとリクエストが正常に受け付けられない可能性があります。</td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>phone_number</td>
    <td>携帯電話番号</td>
    <td>配列：文字列</td>
    <td></td>
    <td></td>
    <td>検索条件の宛先の携帯電話番号を指定する<span class="asterisk">※1</span></br>
        配列に指定する値は50件以内にしてください。</br>
        50件を超えるとリクエストが正常に受け付けられない可能性があります。</td>
  </tr>
  <tr>
    <td class="container">3</td>
    <td>status</td>
    <td>ステータス</td>
    <td>配列：数値</td>
    <td></td>
    <td></td>
    <td>50:予約中<br>
        100:配信中<br>
        200:送達<br>
        300:配信取消<br>
        700:除外<br>
        900:配信失敗</td>
  </tr>
  <tr>
    <td class="container">4</td>
    <td>reserved_from</td>
    <td>配信予定日時FROM</td>
    <td>文字列</td>
    <td></td>
    <td>ISO8601形式</td>
    <td>配信予定日時(自:絞込条件)</td>
  </tr>
  <tr>
    <td class="container">5</td>
    <td>reserved_to</td>
    <td>配信予定日時TO</td>
    <td>文字列</td>
    <td></td>
    <td>ISO8601形式</td>
    <td>配信予定日時(至:絞込条件)</td>
  </tr>
  <tr>
    <td class="container">6</td>
    <td>offset</td>
    <td>取得開始位置</td>
    <td>数値</td>
    <td></td>
    <td></td>
    <td>取得開始位置を指定する。<br>
        指定しない場合、0となる。</td>
  </tr>
  <tr>
    <td class="container">7</td>
    <td>limit</td>
    <td>取得件数</td>
    <td>数値</td>
    <td></td>
    <td></td>
    <td>取得件数を指定する。<br>
        指定しない場合、10000となる。</td>
  </tr>
</table>

<span class="asterisk">※1</span>携帯電話番号の仕様は以下になります。

  - 070,080,090から始まる11桁の番号。ただし、0800から始まる11桁の番号には配信できません。

  - 020から始まる11桁か14桁の番号。

  - 先頭に「+81」を指定した場合「0」に変換されます。

  - 海外キャリアには配信できません。

  - 「‒(ハイフン)」は省略できます。

  - 全角数字は半角に変換されます。



## レスポンス

> ボディ

```json
{
  "total":3,
  "contacts":[
    {
      "delivery_id":"fd75dc2503c20bb62902fabbbddf98e3" ,
      "contact_id":1,
      "carrier": 10,
      "delivery_name":"20180619160536",
      "phone_number":"090xxxxxxxx" ,
      "reserved_at":"2018-06-19T16:05:37+09:00",
      "canceled_at": null,
      "delivered_at":"2018-06-19T16:05:37+09:00",
      "status":200,
      "message":"配信成功",
      "detail": "DTL000001",
      "detail_message": "端末への配信に成功",
      "shorten_url1_click_count":0,
      "shorten_url2_click_count":null,
      "insertion_url1_click_count":1,
      "insertion_url2_click_count":null,
      "opted_out":null,
      "transmission_count": 1
    },
    {
      "delivery_id":"fd75dc2503c20bb62902fabbbddf98e3" ,
      "contact_id":2,
      "carrier": 30,
      "delivery_name":"20180619160536",
      "phone_number":"080xxxxxxxx" ,
      "reserved_at":"2018-06-19T16:05:37+09:00",
      "canceled_at": null,
      "delivered_at":null,
      "status":900,
      "message":"配信失敗",
      "detail": "DTL000007",
      "detail_message": "端末が圏外、または電源offの可能性あり",
      "shorten_url1_click_count":0,
      "shorten_url2_click_count":null,
      "insertion_url1_click_count":0,
      "insertion_url2_click_count":null,
      "opted_out":null,
      "transmission_count": null
    },
    {
      "delivery_id":"fd75dc2503c20bb62902fabbbddf98e3" ,
      "contact_id":3,
      "carrier": 40,
      "delivery_name":"20180619160536",
      "phone_number":"080xxxxxxxx" ,
      "reserved_at":"2018-06-19T16:05:37+09:00",
      "canceled_at": null,
      "delivered_at":null,
      "status": 100,
      "message": "配信中",
      "detail": null,
      "detail_message": null,
      "shorten_url1_click_count":0,
      "shorten_url2_click_count":null,
      "insertion_url1_click_count":0,
      "insertion_url2_click_count":null,
      "opted_out":null,
      "transmission_count": null
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
    <td>宛先の合計件数</td>
  </tr>
  <tr>
    <td class="container">2</td>
    <td>contacts</td>
    <td>宛先一覧</td>
    <td>配列</td>
    <td></td>
    <td>配信の宛先別情報一覧</td>
  </tr>
  <tr>
    <td class="container">2-1</td>
    <td>delivery_id</td>
    <td>配信ID</td>
    <td>文字列</td>
    <td>最大50文字</td>
    <td>SMSLINKが発行した配信ID</td>
  </tr>
  <tr>
    <td class="container">2-2</td>
    <td>contact_id</td>
    <td>宛先ID</td>
    <td>数値</td>
    <td>最大20桁</td>
    <td>SMSLINKが発行した宛先ID</td>
  </tr>
  <tr>
    <td class="container">2-3</td>
    <td>carrier</td>
    <td>キャリア</td>
    <td>数値</td>
    <td></td>
    <td>配信した携帯電話番号のキャリア<br>
        10:docomo<br>
        20:au<br>
        30:softbank<br>
        40:unknown<br>
        50:rakuten</td>
  </tr>
  <tr>
    <td class="container">2-4</td>
    <td>delivery_name</td>
    <td>配信名</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>配信のタイトル</td>
  </tr>
  <tr>
    <td class="container">2-5</td>
    <td>phone_number</td>
    <td>携帯電話番号</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>リクエストで指定した携帯電話番号</td>
  </tr>
  <tr>
    <td class="container">2-6</td>
    <td>reserved_at</td>
    <td>配信予定日時</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>配信の予定日時（YYYY-MM-DDThh:mm:ss+09:00形式）</td>
  </tr>
  <tr>
    <td class="container">2-7</td>
    <td>canceled_at</td>
    <td>キャンセル日時</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>配信のキャンセル日時（YYYY-MM-DDThh:mm:ss+09:00形式）</td>
  </tr>
  <tr>
    <td class="container">2-8</td>
    <td>delivered_at</td>
    <td>配信完了日時</td>
    <td>文字列</td>
    <td>ISO8601形式</td>
    <td>配信の完了日時（YYYY-MM-DDThh:mm:ss+09:00形式）</td>
  </tr>
  <tr>
    <td class="container">2-9</td>
    <td>status</td>
    <td>結果ステータス</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>ステータス一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">2-10</td>
    <td>message</td>
    <td>結果メッセージ</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>ステータス一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">2-11</td>
    <td>detail</td>
    <td>結果詳細ステータス</td>
    <td>文字列</td>
    <td>最大10文字</td>
    <td>ステータス一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">2-12</td>
    <td>detail_message</td>
    <td>結果詳細メッセージ</td>
    <td>文字列</td>
    <td>最大255文字</td>
    <td>ステータス一覧を参照<span class="asterisk">※1</span></td>
  </tr>
  <tr>
    <td class="container">2-13</td>
    <td>shorten_url1_click_count</td>
    <td>本文URL1のクリック回数</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>本文URL1のクリック回数<br>
        null:クリックカウント指定なし</td>
  </tr>
  <tr>
    <td class="container">2-14</td>
    <td>shorten_url2_click_count</td>
    <td>本文URL2のクリック回数</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>本文URL2のクリック回数<br>
        null:クリックカウント指定なし</td>
  </tr>
  <tr>
    <td class="container">2-15</td>
    <td>insertion_url1_click_count</td>
    <td>差込短縮URL1のクリック回数</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>差込短縮URL1のクリック回数<br>
        null:差込短縮URL1の差し込みなし</td>
  </tr>
  <tr>
    <td class="container">2-16</td>
    <td>insertion_url2_click_count</td>
    <td>差込短縮URL2のクリック回数</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>差込短縮URL2のクリック回数<br>
        null:差込短縮URL2の差し込みなし</td>
  </tr>
  <tr>
    <td class="container">2-17</td>
    <td>opted_out</td>
    <td>配信停止申請フラグ</td>
    <td>真偽値</td>
    <td></td>
    <td>true:申請あり<br>
        false:申請なし<br>
        null:配信停止指定なし</td>
  </tr>
   <tr>
    <td class="container">2-16</td>
    <td>transmission_count</td>
    <td>通数</td>
    <td>数値</td>
    <td>最大11桁</td>
    <td>配信したSMSの通数<span class="asterisk">※2</span><br>
        null:配信していない場合</td>
  </tr>
</table>
<br/>

<span class="asterisk">※1</span>ステータス一覧

|status|message|detail|detail_message|説明|
| --- | --- | --- | --- | --- |
|50|予約中| | |予約中のステータスです<br>detailとdetail_messageはnullです|
|100|配信中| | |配信中のステータスです<br>detailとdetail_messageはnullです|
|200|配信成功|DTL000001|端末への配信に成功|正常に配信されたステータスです|
|300|配信取消| | |配信取消されたステータスです|
|700|配信不可|DTL000002|携帯電話番号がない為、配信対象に登録できませんでした|携帯電話番号未入力のため配信対象から除外されました|
|700|配信不可|DTL000003|携帯電話番号が11桁か14桁ではない為、配信対象に 登録できませんでした|携帯電話番号の桁数が不足または超えているため配信対象から除外されました|
|700|配信不可|DTL000004|携帯電話番号が重複した為、配信対象に登録できませんでした|携帯電話番号が宛先一覧の中で重複したため除外されました|
|700|配信不可|DTL000005|配信不可な携帯電話番号の為、配信対象に登録できませんでした。|携帯電話番号の形式ではないため除外されました|
|900|配信失敗|DTL000006|キャリア配信に失敗しました| キャリア側の都合で配信に失敗しました|
|900|配信失敗|DTL000007|端末が圏外、または電源offの可能性あり|端末が圏外か電源offの可能性がある為配信に失敗しました|
|900|配信失敗|DTL000011|SMSが受信できない番号の可能性あり|SMSが受信できない番号の可能性があるため配信に失敗しました|
|700|配信不可|DTL000012|宛先項目が255文字を超えてる為、配信対象に登録できませんでした|宛先項目が桁数オーバーしています|
|700|配信不可|DTL000013|差込項目に使用できない文字がある為、配信対象に登録できませんでした|使用できない文字を使用しています|
|700|配信不可|DTL000014|本文が差込項目含めて660文字を超えてる為、配信対象に登録できませんでした|本文が桁数オーバーしています|
|900|配信失敗|DTL000017|携帯電話番号が配信停止番号に登録されているため、配信できませんでした|携帯電話番号が配信停止番号に登録されています|
|700|配信不可|DTL000018|携帯電話番号入手時期が無効の為、配信対象に登録できませんでした。|携帯電話番号入手時期が無効な日付か、日付形式以外の文字を使用しているため配信対象から除外されました<span class="asterisk">※3</span>|
|900|配信失敗|DTL000019|誤送信防止機能により、配信に失敗しました。|携帯電話番号の持ち主が変わったため配信に失敗しました<span class="asterisk">※3</span>|
|900|配信失敗|DTL000020|誤送信防止機能で判定に失敗したため配信しませんでした。|携帯電話番号の持ち主変更の判定に失敗したため配信に失敗しました<span class="asterisk">※3</span>|
|900|配信失敗|DTL000025|配信禁止時間帯のため、配信できませんでした。|配信禁止時間帯の配信となったため、配信に失敗しました<span class="asterisk">※4</span>|

<br/>

<span class="asterisk">※2</span> 配信したSMSの通数の仕様は以下になります。

- docomoの場合

    - 1通は70文字(半角全角文字問わず)までとなります。

    - 70文字を超えた場合は66文字(半角全角文字問わず)毎に1通で計算します。

- auの場合

    - 1通は70文字(半角全角文字問わず)までとなります。

    - 70文字を超えた場合は67文字(半角全角文字問わず)毎に1通で計算します。

- softbankの場合

    - 1通は660文字(半角全角文字問わず)までとなります。

- rakutenの場合

    - 1通は70文字(半角全角文字問わず)までとなります。

    - 70文字を超えた場合は67文字(半角全角文字問わず)毎に1通で計算します。

- 「配信者英字表示」を利用する場合

  - キャリア問わず

    - 1通は70文字(半角文字のみの場合は140文字)までとなります。

    - 70文字を超えた場合は67文字(半角文字のみの場合は134文字)毎に1通で計算します。

<span class="asterisk">※3</span> 誤送信防止APIで配信した案件の場合のみ

<span class="asterisk">※4</span> 配信禁止時間帯の設定が有効な契約で配信した案件の場合のみ
