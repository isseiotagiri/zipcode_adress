# 郵便番号検索 & SMS送信アプリ

このアプリケーションは郵便番号から住所を検索し、SMS送信機能を提供するRailsアプリケーションです。

## 機能

- 郵便番号から住所を検索
- 携帯電話番号にSMSを送信

## セットアップ

### 1. 依存関係のインストール

```bash
bundle install
```

### 2. 環境変数の設定

`.env`ファイルを作成し、SMS API トークンを設定してください：

```bash
cp .env.sample .env
```

`.env`ファイルを編集：

```env
SMS_API_TOKEN=your_actual_api_token_here
```

### 3. アプリケーションの起動

```bash
rails server
```

ブラウザで `http://localhost:8080` にアクセスしてください。

## 使用方法

### 郵便番号検索

1. 郵便番号（例: 123-4567）を入力
2. 「検索」ボタンをクリック
3. 該当する住所が表示されます

### SMS送信

1. 携帯番号（例: 090-1234-5678）を入力
2. 送信したいメッセージを入力
3. 「送信」ボタンをクリック
4. SMSが送信されます

## 技術仕様

- Ruby version: 3.3.8
- Rails version: 7.1.0
- 郵便番号検索API: zipcloud.ibsnet.co.jp
- SMS API: sand-api-smslink.nexlink2.jp

## API仕様

SMS送信にはNEXLINK2のSMS APIを使用しています。詳細な仕様は`api_reference/`フォルダ内のドキュメントを参照してください。
