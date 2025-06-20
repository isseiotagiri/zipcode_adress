# API Reference フォルダ構成ドキュメント

## フォルダ構造図
```text
api_reference/
├─ .dockerignore
├─ .editorconfig
├─ .ruby-version
├─ .travis.yml
├─ Dockerfile
├─ Vagrantfile
├─ config.rb
├─ Gemfile
├─ Gemfile.lock
├─ slate.sh
├─ README.md
├─ CHANGELOG.md
├─ CODE_OF_CONDUCT.md
├─ LICENSE
├─ lib/
│   ├─ monokai_sublime_slate.rb
│   ├─ multilang.rb
│   ├─ nesting_unique_head.rb
│   ├─ nesting_unique_head_multibyte_character.rb
│   ├─ toc_data.rb
│   └─ unique_head.rb
└─ source/
    ├─ index.html.md
    ├─ sms.html.md
    ├─ verification_code.html.md
    ├─ webhook.html.md
    ├─ receiption.html.md
    ├─ changelog.html.md
    ├─ error_list.html.md
    ├─ includes/
    │   ├─ _changelog.md
    │   ├─ _template.md
    │   ├─ sms/
    │   │   ├─ _delivery_registration.md
    │   │   ├─ _delivery_reservation_cancellation.md
    │   │   ├─ _get_delivery_results.md
    │   │   └─ _use_safe_delivery.md
    │   ├─ verification_code/
    │   │   ├─ _delivery.md
    │   │   ├─ _delivery_result.md
    │   │   ├─ _generate_and_delivery.md
    │   │   └─ _verify.md
    │   ├─ receiption/
    │   └─ webhook/
    ├─ stylesheets/
    ├─ javascripts/
    ├─ images/
    ├─ fonts/
    └─ layouts/
``` 

## 各フォルダの役割

- **ルート直下**
  - プロジェクト設定（Dockerfile、Vagrantfile、CI設定など）とメタ情報（README、LICENSE、CHANGELOG）
  - `config.rb`: Middlemanによる静的サイト生成の設定
  - `Gemfile`／`Gemfile.lock`: Ruby依存管理

- **lib/**
  - ドキュメント生成用のカスタム拡張ライブラリ
  - シンタックスハイライトや多言語対応、見出し処理などのスクリプト

- **source/**
  - Markdown形式のAPIコンテンツ本体と部分テンプレート(include)
  - `includes/`：再利用可能なパーシャル（サンプルコードや説明文）
  - `stylesheets/`, `javascripts/`, `images/`, `fonts/`, `layouts/`: Webサイト表示用アセット

## ファイル分類

### 拡張子別分布（概算）

| 拡張子     | 用途                      | ファイル数 | 重要度 |
|------------|---------------------------|----------:|-------:|
| .md        | ドキュメント              | 20+       | ★★★    |
| .rb        | Rubyスクリプト／拡張       | 6         | ★★★    |
| .scss/.css | スタイルシート            | 6         | ★★     |
| .js        | JavaScript                | 5+        | ★★     |
| .erb       | レイアウトテンプレート    | 1         | ★★     |
| .json      | 設定ファイル              | 1         | ★      |
| .yml/.yaml | CI/CD・設定               | 2         | ★      |

### 重要ファイル

- **config.rb**: Middleman設定
- **Gemfile/Gemfile.lock**: 依存関係管理
- **source/index.html.md**: メインAPIリファレンス
- **Dockerfile**: コンテナ化・デプロイ設定

## 構成の評価と推奨事項

**良い点**
- 設定／ライブラリ／コンテンツの明確な分離
- `includes/`によるDRYな部分テンプレート化
- Docker・CI対応による再現性ある開発環境

**改善提案**
1. ドキュメントを機能別・バージョン別に整理するサブディレクトリを導入
   - 例: `source/api/`, `source/guides/`, `source/versions/v1/`
2. CIパイプラインにリンクチェック／HTML校正（gem 'html-proofer'）を追加
3. 自動テスト（RSpec, Capybara）でビルド結果を検証
4. 画像最適化・CDN配信によるパフォーマンス向上

## 利用者向けガイド

- **API利用者（開発者）**
  1. `source/index.html.md`で概要確認
  2. 機能別（sms, verification_code, webhook等）のMarkdownを参照
  3. `includes/`以下のサンプルコードを活用

- **ドキュメントメンテナー**
  - 新API追加時は`source/includes/<機能>/`にパーシャル追加
  - メインMarkdownで`partial`タグを利用してコンテンツを展開
  - `config.rb`で必要な拡張設定を追加

- **インフラ担当者**
  - `Dockerfile`／`.travis.yml`でビルドとデプロイを管理
  - `docker compose up api_reference`でローカル動作確認

---
**作成日**: 2025-06-17
