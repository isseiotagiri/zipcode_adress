# 05-02 停止リスト全停止削除（FAX）

> HTTPメソッド及び、URL

```
DELETE /api/v1/excluded_fax_numbers
```

指定された停止リスト全停止（FAX）をNEXLINKから削除します。

停止リスト全停止（FAX）を誤って登録した際など、本APIを使用して削除します。

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
    "fax_no": [
        "03-XXXX-XXXX",
        "06XXXXXXXX"
      ]
}
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/excluded_fax_numbers" \
  -d '{ "fax_no": ["03-XXXX-XXXX","06XXXXXXXX"] }' \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| fax_no | 削除対象のFAX番号	| 配列:文字列 | 削除したいFAX番号を複数指定</br>`["03-XXXX-XXXX","06XXXXXXXX",...]`</br>最大`10万`件 |

## レスポンス
> ボディ

```json
{
    "total_count": 2,
    "success_count": 1,
    "error_count": 1,
    "errors": [
        {
            "error_message": "FAX番号が存在しません。",
            "fax_no": "03-XXXX-XXXX"
        }
    ]
}

```

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| total_count | 入力値の合計件数 | 数値 | 入力値の合計件数 |
| success_count | 削除に成功した件数 | 数値 | 削除に成功した件数 |
| error_count | 削除に失敗した件数 | 数値| 削除に失敗した件数 |
| errors<span class="notice">※1</span> | エラー内容| 配列:文字列 |  削除に失敗した理由とFAX番号の配列<br><span class="notice">※1: 全て登録に成功した場合は空の配列となります</span> |
| &nbsp;&nbsp;error_message | エラー内容 | 文字列 | 削除に失敗した理由 |
| &nbsp;&nbsp;fax_no | FAX番号 | 文字列 | 削除に失敗したFAX番号 |
