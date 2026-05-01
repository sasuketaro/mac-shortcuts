# mac-shortcuts

対象アプリのウィンドウを自動配置し、そのアプリのショートカットを表示するmacOSアプリです。

## リポジトリ

https://github.com/sasuketaro/mac-shortcuts.git

## アプリ要件

### ウィンドウ管理
- 本アプリ起動後、次にアクティブになったアプリ（対象アプリ）を自動検出
- 対象アプリのウィンドウ → 画面左 3/4 に配置
- 本アプリのウィンドウ → 画面右 1/4 に配置
- 画面分割比率：対象アプリ：本アプリ = 3：1

### ショートカット表示
- 対象アプリのショートカットを「コマンド → 説明」形式で表示
- 説明は簡潔に記載（日本語）
- 表示優先順位：スクロール → ナビゲーション → タブ操作 → 編集 → その他
- スクロール・画面ナビゲーション系コマンドを最優先表示

### 対応アプリ
- Safari
- Google Chrome
- Firefox
- Terminal
- Visual Studio Code
- Finder
- Slack
- Xcode
- 汎用（未対応アプリへのフォールバック）

## 技術スタック

- 言語: Swift
- UI: SwiftUI + AppKit
- ビルド: Swift Package Manager
- 必要権限: アクセシビリティ（ウィンドウ操作）

## ビルド・実行方法

```bash
swift build
swift run
```

### 初回セットアップ
1. `swift run` で起動
2. アクセシビリティ権限のダイアログが表示されたら「開く」
3. システム設定 > プライバシーとセキュリティ > アクセシビリティ でアプリを許可
4. アプリを再起動

## ディレクトリ構成

```
mac-shortcuts/
├── CLAUDE.md
├── .env
├── .gitignore
├── Package.swift
└── Sources/
    └── MacShortcuts/
        ├── main.swift               # エントリポイント
        ├── AppDelegate.swift        # アプリライフサイクル・監視
        ├── AppState.swift           # 共有状態管理
        ├── Models.swift             # データモデル
        ├── ContentView.swift        # UI
        ├── WindowManager.swift      # ウィンドウ配置ロジック
        └── ShortcutsDatabase.swift  # ショートカットデータ
```

## 開発メモ

- 変更のたびにGitHubへプッシュする運用とする
- アクセシビリティAPIを使用しているため、初回はシステム設定での許可が必要
