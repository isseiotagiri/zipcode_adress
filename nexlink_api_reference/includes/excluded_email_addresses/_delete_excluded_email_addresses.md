# 06-02 停止リスト全停止削除（メール）

> HTTPメソッド及び、URL

```
DELETE /api/v1/excluded_email_addresses
```

指定された停止リスト全停止（メール）をNEXLINKから削除します。

停止リスト全停止（メール）を誤って登録した際など、本APIを使用して削除します。

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
    "email_addresses": [
        "test@example.com",
        "test+1@example.com"
      ]
}
```

> サンプルコード

``` sh
curl "https://sandbox-hea.nexlink2.jp/api/v1/excluded_email_addresses" \
  -d '{ "email_addresses": ["test@example.com","test+1@example.com"] }' \
  -X DELETE \
  -H "Accept: application/json" \
  -H "Authorization: token YOUR_API_TOKEN" \
  -H "Content-Type: application/json"
```

### パラメータ

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| email_addresses | 削除対象のメールアドレス	| 配列:文字列 | 削除したいメールアドレスを複数指定</br>`["〜@example.com","〜@example.com",...]`</br>最大`10万`件 |

## レスポンス
> ボディ

```json
{
    "total_count": 2,
    "success_count": 1,
    "error_count": 1,
    "errors": [
        {
            "error_message": "メールアドレスが存在しません。",
            "email_address": "test@example.com"
        }
    ]
}

```

| 物理名 | 論理名 | 型 | 説明 |
| ---- | ---- | ---- | ---- |
| total_count | 入力値の合計件数 | 数値 | 入力値の合計件数  |
| success_count | 削除に成功した件数 | 数値 | 削除に成功した件数 |
| error_count |  削除に失敗した件数|  数値| 削除に失敗した件数 |
| errors<span class="notice">※1</span> |  エラー内容| 配列:文字列 |  削除に失敗した理由とメールアドレスの配列<br><span class="notice">※1: 全て登録に成功した場合は空の配列となります</span> |
| &nbsp;&nbsp;error_message | エラー内容 | 文字列 | 削除に失敗した理由 |
| &nbsp;&nbsp;email_address | メールアドレス | 文字列 | 削除に失敗したメールアドレス |
