# import で導入しているフレームワーク一覧

Swift では `import フレームワーク名` と書くことで、Apple が用意した機能セットをまとめて使えるようになります。
このプロジェクトで使用しているフレームワーク（ライブラリ）を説明します。

---

## Cocoa

```swift
import Cocoa  // AppDelegate.swift, main.swift, WindowManager.swift, AppState.swift
```

### 何ができるか
macOS アプリを作るための「総合パッケージ」です。  
`AppKit`・`Foundation`・`CoreData` などを一括で読み込んでくれます。  
このひとつを書くだけで、ウィンドウ・ボタン・テキストなど macOS の UI 部品をほぼ全て使えるようになります。

### 主に使っている機能
| クラス・機能 | 説明 |
|---|---|
| `NSApplication` | アプリ本体を表すクラス。起動・終了・イベントループを管理する |
| `NSWindow` | ウィンドウを作成・移動・リサイズするクラス |
| `NSScreen` | 画面サイズや使用可能領域（visibleFrame）を取得するクラス |
| `NSWorkspace` | 他のアプリの起動・終了・切り替えなどシステムイベントを監視する |
| `NSRunningApplication` | 現在動いているアプリの情報（名前・ID・アイコン）を持つクラス |

---

## SwiftUI

```swift
import SwiftUI  // AppDelegate.swift, ContentView.swift
```

### 何ができるか
Apple が 2019 年に発表した**最新の UI フレームワーク**です。  
コードで「何を表示するか」を宣言的に書くだけで、自動的に画面が作られます。  
変数が変わると画面が自動で更新される仕組みが組み込まれています。

### 主に使っている機能
| 機能 | 説明 |
|---|---|
| `View` プロトコル | 画面部品を定義するための「設計図」の型 |
| `VStack / HStack` | 子要素を縦・横に並べるコンテナ |
| `Text` | 文字を表示する部品 |
| `Image` | 画像・アイコンを表示する部品 |
| `ScrollView` | スクロール可能な領域を作る |
| `ForEach` | 配列の要素分だけ繰り返し部品を生成する |
| `Section` | リストをグループ分けして、ヘッダーを固定表示する |
| `@State` | View 内だけで使うローカルな状態変数（変わると再描画される） |
| `@EnvironmentObject` | 親から渡された共有状態オブジェクトを受け取る |
| `NSHostingView` | SwiftUI の View を AppKit（NSWindow）に埋め込む橋渡し役 |

---

## AppKit

```swift
import AppKit  // ContentView.swift, ShortcutsDatabase.swift
```

### 何ができるか
macOS の UI 部品を作る**伝統的なフレームワーク**（2001 年〜）です。  
`Cocoa` を import すると自動的に含まれますが、SwiftUI ファイルでは明示的に書いています。

### このプロジェクトでの使い方
SwiftUI だけでは取得できない macOS 固有の色や値を使うために import しています。

| 機能 | 説明 |
|---|---|
| `NSColor.windowBackgroundColor` | macOS のウィンドウ標準背景色（ライト/ダークモード対応） |
| `NSColor.controlBackgroundColor` | コントロール（リストなど）の背景色 |
| `NSRunningApplication` | 動作中のアプリ情報（アイコン・名前・バンドルID）を取得 |

---

## ApplicationServices

```swift
import ApplicationServices  // AppDelegate.swift, WindowManager.swift
```

### 何ができるか
macOS の**アクセシビリティ API（AX API）**を使うためのフレームワークです。  
アクセシビリティとは「視覚障害者向けの補助機能」のための仕組みですが、  
他のアプリのウィンドウを**プログラムから操作する**ためにも使われます。

> ⚠️ このフレームワークを使うには、システム設定 > プライバシーとセキュリティ > **アクセシビリティ** でアプリを許可する必要があります。

### 主に使っている機能
| 関数・定数 | 説明 |
|---|---|
| `AXIsProcessTrustedWithOptions` | このアプリがアクセシビリティ権限を持っているか確認する。未許可なら許可ダイアログを表示する |
| `AXUIElementCreateApplication(pid)` | 他のアプリを「操作するためのハンドル」として取得する |
| `AXUIElementCopyAttributeValue` | ハンドルから情報（ウィンドウ一覧など）を読み取る |
| `AXUIElementSetAttributeValue` | ハンドル経由でウィンドウの位置・サイズを変更する |
| `kAXWindowsAttribute` | 「ウィンドウ一覧を取得する」を意味するキー定数 |
| `kAXPositionAttribute` | 「ウィンドウの位置を操作する」を意味するキー定数 |
| `kAXSizeAttribute` | 「ウィンドウのサイズを操作する」を意味するキー定数 |
| `AXValueCreate` | `CGPoint`（座標）や `CGSize`（サイズ）を AX API が受け取れる形式に変換する |

---

## Combine

```swift
import Combine  // AppState.swift
```

### 何ができるか
Apple が 2019 年に発表した**リアクティブプログラミング**のフレームワークです。  
「ある値が変わったら、関係するすべての場所に自動で通知する」という仕組みを提供します。

### このプロジェクトでの使い方
`AppState` クラスの `@Published` プロパティを動かすために必要です。

```swift
@Published var targetApp: NSRunningApplication?
//  ↑ この変数が変わると、SwiftUI の ContentView が自動で再描画される
```

| 機能 | 説明 |
|---|---|
| `ObservableObject` | 変数の変化を外部に通知できるクラスにするためのプロトコル |
| `@Published` | この変数が変わったとき、購読者（SwiftUI の View など）に自動通知するマーカー |

---

## Foundation

```swift
import Foundation  // Models.swift
```

### 何ができるか
Swift / Objective-C 共通の**基本データ型と便利機能**を提供するフレームワークです。  
文字列・数値・日付・ファイル操作など、プログラムの土台となる機能が入っています。

### このプロジェクトでの使い方
`Models.swift` で `UUID` を使うために import しています。

| 機能 | 説明 |
|---|---|
| `UUID` | 世界で一意（重複しない）な ID を自動生成するクラス。リストの各要素を区別するために使う |
| `String` | 文字列型（Foundation がなくても使えるが、高度な文字列操作は Foundation が必要） |

---

## フレームワークの関係図

```
Cocoa（総合パッケージ）
 ├── AppKit        … macOS の UI 部品（NSWindow, NSScreen など）
 ├── Foundation    … 基本データ型（String, UUID など）
 └── CoreData      … データ永続化（このプロジェクトでは未使用）

SwiftUI             … 宣言的 UI フレームワーク（AppKit の上位互換的な位置づけ）
ApplicationServices … アクセシビリティ API（他アプリのウィンドウ操作）
Combine             … リアクティブプログラミング（値の変化を自動伝播）
```

---

## なぜ Swift を選んだか

| 観点 | 説明 |
|---|---|
| **ネイティブ性能** | macOS 向けに最適化されており、動作が速い |
| **Apple 公式** | AppKit / SwiftUI / Accessibility API すべてを純粋な Swift で扱える |
| **型安全** | コンパイル時にミスを検出できるため、バグが少ない |
| **モダンな構文** | Python に近い読みやすい文法で書ける |
| **ビルドが簡単** | Swift Package Manager（SPM）で `swift run` 1コマンドで動く |
