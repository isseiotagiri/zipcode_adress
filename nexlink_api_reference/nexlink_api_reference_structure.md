以下は nexlink_api_reference フォルダの構造と内容についてのドキュメント例です。新メンバーが全体像をすばやくつかめるようにまとめています。

---

# nexlink_api_reference ドキュメント

## 1. プロジェクト概要
- **目的**  
  FAX／メール送信に関するREST API仕様をまとめた静的ドキュメントサイトです。  
- **技術スタック**  
  - Markdownベースのテンプレート（拡張子 `.html.md`）  
  - Ruby＋Middleman（もしくはSlate）によるビルド  
  - 各種アセット管理（CSS/JS/フォント/画像）

## 2. ディレクトリ構造と説明

```
nexlink_api_reference/
├─ CHANGELOG.md                # リリース履歴
├─ contact_lists.html.md       # 送信先一覧API仕様
├─ emails.html.md              # メール送信API仕様
├─ error_list.html.md          # 共通エラー一覧
├─ excluded_email_addresses.html.md    # メール除外アドレスAPI
├─ excluded_fax_numbers.html.md        # FAX除外番号API
├─ exclusion_contact_lists.html.md     # 除外リストAPI
├─ facsimiles.html.md          # FAX送信API仕様
├─ index.html.md               # トップページ（全体概要）
├─ fonts/                      # ドキュメント用フォントファイル
├─ images/                     # アイコン・図版
├─ includes/                   # 共通ヘッダー・フッター等の部分テンプレート
├─ javascripts/                # インタラクティブ動作用JavaScript
├─ layouts/                    # ページレイアウトテンプレート
├─ stylesheets/                # デザイン用CSS
└─ config.rb                   # Middleman/Slateの設定ファイル
```

### 各フォルダの役割
- `*.html.md`  
  各APIエンドポイントの仕様書（Markdown＋Front Matter形式）。  
- `fonts/`, `images/`, `javascripts/`, `stylesheets/`  
  ドキュメントUIを構成する静的アセット。  
- `includes/`  
  ナビゲーションバー、サイドメニューなどの部分テンプレートを格納。  
- `layouts/`  
  全体レイアウト定義（HTMLの骨組み）  
- `config.rb`  
  ビルド設定（プレビュー用サーバ起動オプションや出力先設定など）

## 3. ドキュメント類の配置
- **トップページ**  
  - `index.html.md`：API全体の概要と利用ガイドリンク  
- **エンドポイント個別仕様**  
  - `facsimiles.html.md`：FAX送信  
  - `emails.html.md`：メール送信  
  - `contact_lists.html.md`：送信先リスト取得・登録  
  - `excluded_email_addresses.html.md`：メール除外アドレス操作  
  - `excluded_fax_numbers.html.md`：FAX除外番号操作  
  - `exclusion_contact_lists.html.md`：除外リスト操作  
- **共通リファレンス**  
  - `error_list.html.md`：全エンドポイント共通のエラーコード一覧  
- **変更履歴**  
  - `CHANGELOG.md`：リリースごとの更新内容

## 4. 新メンバー向けガイド
1. **ローカル起動**  
   ```bash
   cd nexlink_api_reference
   bundle install         # 必要なGemをインストール
   bundle exec middleman server  # ローカルプレビュー
   ```
2. **ページ追加／更新手順**  
   - `*.html.md` にMarkdownで要件を追記  
   - 必要に応じて `includes/` に共通パーツを追加  
   - `config.rb` でメニューに自動反映されるか確認  
3. **ビルド／デプロイ**  
   ```bash
   bundle exec middleman build
   ```
   → `build/` 以下に静的ファイルが生成。  
4. **ポイント**  
   - Markdownファイル上部のFront Matter（タイトル・URLパス）を忘れずに設定  
   - 既存のレイアウトやCSSクラスを流用し、一貫した見た目を保つ  

---

このドキュメントを参照すれば、nexlink_api_reference の全体構成と更新手順が一目でわかるはずです。新メンバーはまずトップの `index.html.md` を開き、フローを理解した上で個別のエンドポイント仕様に目を通してください。
