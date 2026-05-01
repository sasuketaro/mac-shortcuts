// ─────────────────────────────────────────────
// ShortcutsDatabase.swift
// 各アプリのショートカット一覧データを持つクラス。
// アプリのバンドルID（例: com.apple.Safari）や名前で
// どのアプリかを判定し、対応するショートカット一覧を返す。
// ─────────────────────────────────────────────
import AppKit

class ShortcutsDatabase {
    // アプリ内でただ一つのインスタンスを共有する（シングルトン）
    static let shared = ShortcutsDatabase()
    private init() {}

    // ─── アプリに対応するショートカット一覧を返す ───
    func shortcuts(for app: NSRunningApplication) -> [ShortcutGroup] {
        let id   = app.bundleIdentifier?.lowercased() ?? ""
        let name = app.localizedName?.lowercased()    ?? ""

        switch true {
        case id.contains("safari")   || name == "safari":             return safari
        case id.contains("chrome")   || name.contains("chrome"):      return chrome
        case id.contains("firefox")  || name.contains("firefox"):     return firefox
        case id.contains("terminal") || name == "terminal":           return terminal
        case id.contains("vscode")   || name.contains("visual studio code") || name == "code":
                                                                      return vscode
        case id.contains("finder")   || name == "finder":             return finder
        case id.contains("slack")    || name == "slack":              return slack
        case id.contains("xcode")    || name == "xcode":              return xcode
        default:                                                       return generic
        }
    }

    // MARK: - Safari
    private var safari: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "Space",     description: "下スクロール"),
            Shortcut(command: "⇧Space",    description: "上スクロール"),
            Shortcut(command: "⌘↓",        description: "ページ末尾"),
            Shortcut(command: "⌘↑",        description: "ページ先頭"),
            Shortcut(command: "↑ / ↓",     description: "1行スクロール"),
            Shortcut(command: "← / →",     description: "横スクロール"),
        ]),
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘[",        description: "前のページ"),
            Shortcut(command: "⌘]",        description: "次のページ"),
            Shortcut(command: "⌘L",        description: "アドレスバー選択"),
            Shortcut(command: "⌘R",        description: "再読み込み"),
            Shortcut(command: "⌘⇧R",       description: "リーダー表示"),
            Shortcut(command: "⌘⌥F",       description: "スマート検索フィールド"),
        ]),
        ShortcutGroup(category: "ページ内検索", shortcuts: [
            Shortcut(command: "⌘F",        description: "ページ内検索を開く"),
            Shortcut(command: "⌘G",        description: "次の検索結果"),
            Shortcut(command: "⌘⇧G",       description: "前の検索結果"),
            Shortcut(command: "⌘E",        description: "選択テキストで検索"),
            Shortcut(command: "⎋",         description: "検索を閉じる"),
        ]),
        ShortcutGroup(category: "タブ操作", shortcuts: [
            Shortcut(command: "⌘T",        description: "新規タブ"),
            Shortcut(command: "⌘W",        description: "タブを閉じる"),
            Shortcut(command: "⌘⇧T",       description: "閉じたタブを開く"),
            Shortcut(command: "⌘⇧]",       description: "右のタブへ"),
            Shortcut(command: "⌘⇧[",       description: "左のタブへ"),
            Shortcut(command: "⌘1〜9",      description: "タブ番号で移動"),
            Shortcut(command: "⌘⇧N",       description: "プライベートウィンドウ"),
        ]),
        ShortcutGroup(category: "表示・その他", shortcuts: [
            Shortcut(command: "⌘+",        description: "ズームイン"),
            Shortcut(command: "⌘-",        description: "ズームアウト"),
            Shortcut(command: "⌘0",        description: "ズームリセット"),
            Shortcut(command: "⌘D",        description: "ブックマーク追加"),
            Shortcut(command: "⌘⇧D",       description: "Reading List に追加"),
            Shortcut(command: "⌘N",        description: "新規ウィンドウ"),
            Shortcut(command: "⌘P",        description: "印刷"),
            Shortcut(command: "⌘S",        description: "ページを保存"),
        ]),
    ] }

    // MARK: - Chrome
    private var chrome: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "Space",     description: "下スクロール"),
            Shortcut(command: "⇧Space",    description: "上スクロール"),
            Shortcut(command: "⌘↓",        description: "ページ末尾"),
            Shortcut(command: "⌘↑",        description: "ページ先頭"),
            Shortcut(command: "↑ / ↓",     description: "1行スクロール"),
        ]),
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘[",        description: "前のページ"),
            Shortcut(command: "⌘]",        description: "次のページ"),
            Shortcut(command: "⌘L",        description: "アドレスバー選択"),
            Shortcut(command: "⌘R",        description: "再読み込み"),
            Shortcut(command: "⌘⇧R",       description: "キャッシュ無視して再読込"),
        ]),
        ShortcutGroup(category: "ページ内検索", shortcuts: [
            Shortcut(command: "⌘F",        description: "ページ内検索"),
            Shortcut(command: "⌘G",        description: "次の検索結果"),
            Shortcut(command: "⌘⇧G",       description: "前の検索結果"),
            Shortcut(command: "⌘E",        description: "選択テキストで検索"),
        ]),
        ShortcutGroup(category: "タブ操作", shortcuts: [
            Shortcut(command: "⌘T",        description: "新規タブ"),
            Shortcut(command: "⌘W",        description: "タブを閉じる"),
            Shortcut(command: "⌘⇧T",       description: "閉じたタブを開く"),
            Shortcut(command: "⌘⇧]",       description: "右のタブへ"),
            Shortcut(command: "⌘⇧[",       description: "左のタブへ"),
            Shortcut(command: "⌘1〜8",      description: "タブ番号で移動"),
            Shortcut(command: "⌘9",        description: "最後のタブへ"),
            Shortcut(command: "⌘⇧N",       description: "シークレットウィンドウ"),
        ]),
        ShortcutGroup(category: "デベロッパー", shortcuts: [
            Shortcut(command: "⌘⌥I",       description: "デベロッパーツール"),
            Shortcut(command: "⌘⌥J",       description: "コンソール"),
            Shortcut(command: "⌘⌥C",       description: "要素を検証"),
            Shortcut(command: "⌘U",        description: "ソースを表示"),
        ]),
        ShortcutGroup(category: "その他", shortcuts: [
            Shortcut(command: "⌘D",        description: "ブックマーク追加"),
            Shortcut(command: "⌘⇧B",       description: "ブックマークバー表示切替"),
            Shortcut(command: "⌘⌥B",       description: "ブックマークマネージャー"),
            Shortcut(command: "⌘+",        description: "ズームイン"),
            Shortcut(command: "⌘-",        description: "ズームアウト"),
            Shortcut(command: "⌘0",        description: "ズームリセット"),
            Shortcut(command: "⌘P",        description: "印刷"),
        ]),
    ] }

    // MARK: - Firefox
    private var firefox: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "Space",     description: "下スクロール"),
            Shortcut(command: "⇧Space",    description: "上スクロール"),
            Shortcut(command: "⌘↓",        description: "ページ末尾"),
            Shortcut(command: "⌘↑",        description: "ページ先頭"),
            Shortcut(command: "↑ / ↓",     description: "1行スクロール"),
        ]),
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘[",        description: "前のページ"),
            Shortcut(command: "⌘]",        description: "次のページ"),
            Shortcut(command: "⌘L",        description: "アドレスバー選択"),
            Shortcut(command: "⌘R",        description: "再読み込み"),
            Shortcut(command: "⌘⇧R",       description: "スーパーリロード"),
        ]),
        ShortcutGroup(category: "ページ内検索", shortcuts: [
            Shortcut(command: "⌘F",        description: "ページ内検索"),
            Shortcut(command: "⌘G",        description: "次の検索結果"),
            Shortcut(command: "⌘⇧G",       description: "前の検索結果"),
            Shortcut(command: "⌘E",        description: "選択テキストで検索"),
        ]),
        ShortcutGroup(category: "タブ操作", shortcuts: [
            Shortcut(command: "⌘T",        description: "新規タブ"),
            Shortcut(command: "⌘W",        description: "タブを閉じる"),
            Shortcut(command: "⌘⇧T",       description: "閉じたタブを開く"),
            Shortcut(command: "⌘⌥→",       description: "右のタブへ"),
            Shortcut(command: "⌘⌥←",       description: "左のタブへ"),
            Shortcut(command: "⌘⇧P",       description: "プライベートウィンドウ"),
        ]),
        ShortcutGroup(category: "その他", shortcuts: [
            Shortcut(command: "⌘D",        description: "ブックマーク追加"),
            Shortcut(command: "⌘⇧B",       description: "ブックマーク一覧"),
            Shortcut(command: "⌘⇧H",       description: "履歴"),
            Shortcut(command: "⌘+",        description: "ズームイン"),
            Shortcut(command: "⌘-",        description: "ズームアウト"),
            Shortcut(command: "⌘0",        description: "ズームリセット"),
        ]),
    ] }

    // MARK: - Terminal
    private var terminal: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "⌘↑",        description: "上スクロール"),
            Shortcut(command: "⌘↓",        description: "下スクロール"),
            Shortcut(command: "Fn+↑",      description: "1ページ上へ"),
            Shortcut(command: "Fn+↓",      description: "1ページ下へ"),
            Shortcut(command: "⌘Home",     description: "スクロール先頭"),
            Shortcut(command: "⌘End",      description: "スクロール末尾"),
        ]),
        ShortcutGroup(category: "カーソル移動", shortcuts: [
            Shortcut(command: "⌃A",        description: "行頭へ"),
            Shortcut(command: "⌃E",        description: "行末へ"),
            Shortcut(command: "⌥←",        description: "1単語左へ"),
            Shortcut(command: "⌥→",        description: "1単語右へ"),
            Shortcut(command: "⌃B",        description: "1文字左へ"),
            Shortcut(command: "⌃F",        description: "1文字右へ"),
        ]),
        ShortcutGroup(category: "編集", shortcuts: [
            Shortcut(command: "⌃U",        description: "行を削除"),
            Shortcut(command: "⌃K",        description: "カーソル以降削除"),
            Shortcut(command: "⌃W",        description: "1単語削除"),
            Shortcut(command: "⌃Y",        description: "貼り付け (yank)"),
            Shortcut(command: "⌃T",        description: "前後の文字を入れ替え"),
        ]),
        ShortcutGroup(category: "プロセス・履歴", shortcuts: [
            Shortcut(command: "⌃C",        description: "実行を中断"),
            Shortcut(command: "⌃Z",        description: "バックグラウンドへ"),
            Shortcut(command: "⌃D",        description: "EOF / ログアウト"),
            Shortcut(command: "⌃R",        description: "コマンド履歴検索"),
            Shortcut(command: "⌃L",        description: "画面クリア"),
            Shortcut(command: "↑ / ↓",     description: "履歴を前後に移動"),
            Shortcut(command: "!!",         description: "直前のコマンドを再実行"),
            Shortcut(command: "!$",         description: "直前コマンドの最後の引数"),
            Shortcut(command: "!文字列",    description: "その文字列で始まる直近コマンド"),
        ]),
        ShortcutGroup(category: "タブ・ウィンドウ", shortcuts: [
            Shortcut(command: "⌘T",        description: "新規タブ"),
            Shortcut(command: "⌘W",        description: "タブを閉じる"),
            Shortcut(command: "⌘⇧]",       description: "右のタブへ"),
            Shortcut(command: "⌘⇧[",       description: "左のタブへ"),
            Shortcut(command: "⌘N",        description: "新規ウィンドウ"),
            Shortcut(command: "⌘K",        description: "ターミナルをクリア"),
            Shortcut(command: "⌘+",        description: "フォントサイズを大きく"),
            Shortcut(command: "⌘-",        description: "フォントサイズを小さく"),
        ]),
    ] }

    // MARK: - VS Code
    private var vscode: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "⌃↑",        description: "上にスクロール"),
            Shortcut(command: "⌃↓",        description: "下にスクロール"),
            Shortcut(command: "⌘↑",        description: "ファイル先頭"),
            Shortcut(command: "⌘↓",        description: "ファイル末尾"),
            Shortcut(command: "⌘G",        description: "指定行へジャンプ"),
            Shortcut(command: "⌃PgUp",     description: "1ページ上へ"),
            Shortcut(command: "⌃PgDn",     description: "1ページ下へ"),
        ]),
        ShortcutGroup(category: "ターミナル", shortcuts: [
            Shortcut(command: "⌃`",        description: "ターミナルを開く/閉じる"),
            Shortcut(command: "⌃⇧`",       description: "新規ターミナルを作成"),
            Shortcut(command: "⌃⇧5",       description: "ターミナルを分割"),
            Shortcut(command: "⌃PgUp",     description: "前のターミナルへ"),
            Shortcut(command: "⌃PgDn",     description: "次のターミナルへ"),
            Shortcut(command: "⌘⇧C",       description: "外部ターミナルを開く"),
        ]),
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘P",        description: "ファイル検索"),
            Shortcut(command: "⌘⇧P",       description: "コマンドパレット"),
            Shortcut(command: "⌘F",        description: "ファイル内検索"),
            Shortcut(command: "⌘⇧F",       description: "フォルダ全体検索"),
            Shortcut(command: "⌘⇧H",       description: "フォルダ全体置換"),
            Shortcut(command: "⌃-",        description: "前の位置へ戻る"),
            Shortcut(command: "⌃⇧-",       description: "次の位置へ進む"),
            Shortcut(command: "F12",        description: "定義へジャンプ"),
            Shortcut(command: "⌥F12",       description: "定義をプレビュー"),
            Shortcut(command: "⌘⇧O",       description: "シンボルへジャンプ"),
            Shortcut(command: "F8",         description: "次のエラーへ"),
        ]),
        ShortcutGroup(category: "編集", shortcuts: [
            Shortcut(command: "⌘/",        description: "コメント切替"),
            Shortcut(command: "⌘⌥/",       description: "ブロックコメント切替"),
            Shortcut(command: "⌘D",        description: "同じ単語を追加選択"),
            Shortcut(command: "⌘⇧L",       description: "同じ単語を全て選択"),
            Shortcut(command: "⌘⇧K",       description: "行を削除"),
            Shortcut(command: "⌥↑/↓",      description: "行を移動"),
            Shortcut(command: "⌥⇧↑/↓",     description: "行をコピー"),
            Shortcut(command: "⌘⏎",        description: "下に行を挿入"),
            Shortcut(command: "⌘⇧⏎",       description: "上に行を挿入"),
            Shortcut(command: "⌘⇧I",       description: "インデント整形"),
            Shortcut(command: "F2",         description: "リネーム（全ファイル）"),
        ]),
        ShortcutGroup(category: "マルチカーソル", shortcuts: [
            Shortcut(command: "⌥クリック",  description: "カーソルを追加"),
            Shortcut(command: "⌘⌥↑",       description: "上にカーソルを追加"),
            Shortcut(command: "⌘⌥↓",       description: "下にカーソルを追加"),
            Shortcut(command: "⌘⌥⇧↑/↓",    description: "複数行を選択"),
            Shortcut(command: "⎋",          description: "マルチカーソルを解除"),
        ]),
        ShortcutGroup(category: "ウィンドウ・パネル", shortcuts: [
            Shortcut(command: "⌘B",        description: "サイドバー切替"),
            Shortcut(command: "⌘J",        description: "パネル切替"),
            Shortcut(command: "⌘\\",       description: "エディタを分割"),
            Shortcut(command: "⌘1/2/3",    description: "エディタグループ移動"),
            Shortcut(command: "⌘⇧E",       description: "エクスプローラー"),
            Shortcut(command: "⌘⇧G",       description: "ソース管理"),
            Shortcut(command: "⌘⇧D",       description: "デバッグ"),
            Shortcut(command: "⌘⇧X",       description: "拡張機能"),
            Shortcut(command: "⌘,",        description: "設定を開く"),
            Shortcut(command: "⌘K ⌘S",     description: "ショートカット一覧"),
        ]),
        ShortcutGroup(category: "デバッグ", shortcuts: [
            Shortcut(command: "F5",         description: "デバッグ開始/続行"),
            Shortcut(command: "⇧F5",        description: "デバッグ停止"),
            Shortcut(command: "F9",         description: "ブレークポイント切替"),
            Shortcut(command: "F10",        description: "ステップオーバー"),
            Shortcut(command: "F11",        description: "ステップイン"),
            Shortcut(command: "⇧F11",       description: "ステップアウト"),
        ]),
    ] }

    // MARK: - Finder
    private var finder: [ShortcutGroup] { [
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘↑",        description: "上位フォルダへ"),
            Shortcut(command: "⌘↓",        description: "フォルダを開く"),
            Shortcut(command: "⌘⇧G",       description: "フォルダへ移動"),
            Shortcut(command: "⌘[",        description: "前のフォルダ"),
            Shortcut(command: "⌘]",        description: "次のフォルダ"),
            Shortcut(command: "⌘⇧H",       description: "ホームフォルダ"),
            Shortcut(command: "⌘⇧D",       description: "デスクトップ"),
            Shortcut(command: "⌘⇧A",       description: "アプリケーション"),
            Shortcut(command: "⌘⇧L",       description: "ダウンロード"),
            Shortcut(command: "⌘⇧I",       description: "iCloud Drive"),
            Shortcut(command: "⌘⇧K",       description: "ネットワーク"),
        ]),
        ShortcutGroup(category: "ファイル操作", shortcuts: [
            Shortcut(command: "Space",     description: "クイックルック"),
            Shortcut(command: "⌘O",        description: "開く"),
            Shortcut(command: "⌘Delete",   description: "ゴミ箱へ移動"),
            Shortcut(command: "⌘⇧Delete",  description: "ゴミ箱を空にする"),
            Shortcut(command: "⌘⇧N",       description: "新規フォルダ"),
            Shortcut(command: "⌘I",        description: "情報を見る"),
            Shortcut(command: "⌘D",        description: "複製"),
            Shortcut(command: "⌘L",        description: "エイリアスを作成"),
            Shortcut(command: "⌘⌥V",       description: "移動して貼り付け"),
            Shortcut(command: "⌘⇧.",       description: "隠しファイル表示切替"),
            Shortcut(command: "⌘E",        description: "ディスクを取り出す"),
        ]),
        ShortcutGroup(category: "表示", shortcuts: [
            Shortcut(command: "⌘1",        description: "アイコン表示"),
            Shortcut(command: "⌘2",        description: "リスト表示"),
            Shortcut(command: "⌘3",        description: "カラム表示"),
            Shortcut(command: "⌘4",        description: "ギャラリー表示"),
            Shortcut(command: "⌘J",        description: "表示オプション"),
            Shortcut(command: "⌘F",        description: "検索"),
            Shortcut(command: "⌘⌥S",       description: "サイドバー表示切替"),
            Shortcut(command: "⌘/",        description: "ステータスバー表示切替"),
        ]),
        ShortcutGroup(category: "タブ・ウィンドウ", shortcuts: [
            Shortcut(command: "⌘N",        description: "新規ウィンドウ"),
            Shortcut(command: "⌘T",        description: "新規タブ"),
            Shortcut(command: "⌘W",        description: "ウィンドウを閉じる"),
            Shortcut(command: "⌘⇧]",       description: "右のタブへ"),
            Shortcut(command: "⌘⇧[",       description: "左のタブへ"),
        ]),
    ] }

    // MARK: - Slack
    private var slack: [ShortcutGroup] { [
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘K",        description: "チャンネル/DMに移動"),
            Shortcut(command: "⌘[",        description: "前のチャンネル"),
            Shortcut(command: "⌘]",        description: "次のチャンネル"),
            Shortcut(command: "⌘⇧M",       description: "アクティビティ"),
            Shortcut(command: "⌘⇧K",       description: "DM一覧"),
            Shortcut(command: "⌘⇧A",       description: "すべての未読"),
            Shortcut(command: "⌥↑/↓",      description: "チャンネルを上下移動"),
        ]),
        ShortcutGroup(category: "メッセージ", shortcuts: [
            Shortcut(command: "⏎",         description: "メッセージ送信"),
            Shortcut(command: "⌘⏎",        description: "改行"),
            Shortcut(command: "↑",         description: "直前メッセージを編集"),
            Shortcut(command: "⌘⇧\\",      description: "絵文字リアクション"),
            Shortcut(command: "⌘U",        description: "ファイルをアップロード"),
            Shortcut(command: "⌘B",        description: "太字"),
            Shortcut(command: "⌘I",        description: "斜体"),
            Shortcut(command: "⌘⇧X",       description: "取り消し線"),
            Shortcut(command: "⌘⇧C",       description: "コードブロック"),
        ]),
        ShortcutGroup(category: "スレッド・管理", shortcuts: [
            Shortcut(command: "⌘⇧T",       description: "スレッドを開く"),
            Shortcut(command: "⌘⇧S",       description: "メッセージを保存"),
            Shortcut(command: "⌘⇧P",       description: "ピン留め"),
        ]),
        ShortcutGroup(category: "その他", shortcuts: [
            Shortcut(command: "⌘F",        description: "検索"),
            Shortcut(command: "⌘⇧Y",       description: "ステータス設定"),
            Shortcut(command: "⌘⌥M",       description: "マイク切替"),
            Shortcut(command: "⌘⇧H",       description: "ハドルミーティング"),
            Shortcut(command: "⌘+/-",      description: "フォントサイズ"),
            Shortcut(command: "⌘/",        description: "ショートカット一覧"),
        ]),
    ] }

    // MARK: - Xcode
    private var xcode: [ShortcutGroup] { [
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘⇧O",       description: "ファイルを開く"),
            Shortcut(command: "⌘L",        description: "指定行へジャンプ"),
            Shortcut(command: "⌃6",        description: "メソッド/プロパティ一覧"),
            Shortcut(command: "⌘⌃←/→",     description: "前後の履歴"),
            Shortcut(command: "⌘⌃↑/↓",     description: "ヘッダ/実装切替"),
            Shortcut(command: "⌘⌃J",       description: "定義へジャンプ"),
            Shortcut(command: "⌘⌥J",       description: "フィルタ（ナビゲータ）"),
            Shortcut(command: "⌘1〜9",      description: "ナビゲータパネル切替"),
        ]),
        ShortcutGroup(category: "編集", shortcuts: [
            Shortcut(command: "⌃I",        description: "インデント整形"),
            Shortcut(command: "⌘/",        description: "コメント切替"),
            Shortcut(command: "⌘⌥/",       description: "ドキュメントコメント"),
            Shortcut(command: "⌃⌘E",       description: "スコープ内リネーム"),
            Shortcut(command: "⌘D",        description: "行を複製"),
            Shortcut(command: "⌘⌥[",       description: "行を上へ移動"),
            Shortcut(command: "⌘⌥]",       description: "行を下へ移動"),
            Shortcut(command: "⌃K",        description: "行末まで削除"),
            Shortcut(command: "⌘⇧F",       description: "プロジェクト全体を検索"),
        ]),
        ShortcutGroup(category: "ビルド・実行", shortcuts: [
            Shortcut(command: "⌘R",        description: "ビルドして実行"),
            Shortcut(command: "⌘B",        description: "ビルド"),
            Shortcut(command: "⌘.",        description: "実行停止"),
            Shortcut(command: "⌘U",        description: "テスト実行"),
            Shortcut(command: "⌘⌃U",       description: "テストなしでビルド"),
            Shortcut(command: "⌘⇧K",       description: "ビルドクリア"),
            Shortcut(command: "⌘⌥R",       description: "実行スキームを編集"),
        ]),
        ShortcutGroup(category: "デバッグ", shortcuts: [
            Shortcut(command: "⌘\\",       description: "ブレークポイント切替"),
            Shortcut(command: "⌘Y",        description: "全ブレークポイントの有効/無効"),
            Shortcut(command: "F6",         description: "ステップオーバー"),
            Shortcut(command: "F7",         description: "ステップイン"),
            Shortcut(command: "F8",         description: "ステップアウト"),
            Shortcut(command: "⌃⌘Y",       description: "実行再開"),
            Shortcut(command: "⌘⇧Y",       description: "デバッグエリア表示切替"),
        ]),
        ShortcutGroup(category: "ウィンドウ", shortcuts: [
            Shortcut(command: "⌘0",        description: "ナビゲータ表示切替"),
            Shortcut(command: "⌘⌥0",       description: "インスペクタ表示切替"),
            Shortcut(command: "⌘⌥⏎",       description: "Assistant Editor 表示"),
            Shortcut(command: "⌘⏎",        description: "Standard Editor に戻す"),
        ]),
    ] }

    // MARK: - Generic（未対応アプリへのフォールバック）
    private var generic: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "Space",     description: "下スクロール"),
            Shortcut(command: "⇧Space",    description: "上スクロール"),
            Shortcut(command: "⌘↑",        description: "先頭へ"),
            Shortcut(command: "⌘↓",        description: "末尾へ"),
            Shortcut(command: "↑ / ↓",     description: "1行スクロール"),
        ]),
        ShortcutGroup(category: "システム", shortcuts: [
            Shortcut(command: "⌘Space",    description: "Spotlight 検索"),
            Shortcut(command: "⌃⌘Space",   description: "絵文字・記号の入力"),
            Shortcut(command: "⌘Tab",      description: "アプリ切替（次へ）"),
            Shortcut(command: "⌘⇧Tab",     description: "アプリ切替（前へ）"),
            Shortcut(command: "⌘⌥Esc",     description: "強制終了ウィンドウ"),
            Shortcut(command: "⌃⌘Q",       description: "画面をロック"),
            Shortcut(command: "⌃⌥⌘⏏",     description: "シャットダウン"),
            Shortcut(command: "⌃⌘⏏",      description: "再起動"),
        ]),
        ShortcutGroup(category: "Mission Control", shortcuts: [
            Shortcut(command: "⌃↑",        description: "Mission Control"),
            Shortcut(command: "⌃↓",        description: "App Exposé（現在のAppの全ウィンドウ）"),
            Shortcut(command: "⌃←",        description: "左のデスクトップへ"),
            Shortcut(command: "⌃→",        description: "右のデスクトップへ"),
            Shortcut(command: "⌃1〜9",      description: "デスクトップ番号で移動"),
            Shortcut(command: "F11",        description: "デスクトップを表示"),
        ]),
        ShortcutGroup(category: "基本操作", shortcuts: [
            Shortcut(command: "⌘C",        description: "コピー"),
            Shortcut(command: "⌘V",        description: "貼り付け"),
            Shortcut(command: "⌘X",        description: "切り取り"),
            Shortcut(command: "⌘Z",        description: "取り消す"),
            Shortcut(command: "⌘⇧Z",       description: "やり直す"),
            Shortcut(command: "⌘A",        description: "全選択"),
            Shortcut(command: "⌘F",        description: "検索"),
            Shortcut(command: "⌘S",        description: "保存"),
            Shortcut(command: "⌘⇧S",       description: "別名で保存"),
            Shortcut(command: "⌘P",        description: "印刷"),
        ]),
        ShortcutGroup(category: "ウィンドウ", shortcuts: [
            Shortcut(command: "⌘W",        description: "ウィンドウを閉じる"),
            Shortcut(command: "⌘M",        description: "最小化"),
            Shortcut(command: "⌘H",        description: "隠す"),
            Shortcut(command: "⌘⌥H",       description: "他のアプリを隠す"),
            Shortcut(command: "⌘`",        description: "同じアプリのウィンドウ切替"),
            Shortcut(command: "⌘Q",        description: "アプリを終了"),
        ]),
        ShortcutGroup(category: "スクリーンショット", shortcuts: [
            Shortcut(command: "⌘⇧3",       description: "全画面キャプチャ"),
            Shortcut(command: "⌘⇧4",       description: "範囲選択キャプチャ"),
            Shortcut(command: "⌘⇧4+Space", description: "ウィンドウキャプチャ"),
            Shortcut(command: "⌘⇧5",       description: "スクリーンショットUI"),
            Shortcut(command: "⌘⇧6",       description: "Touch Bar キャプチャ"),
            Shortcut(command: "⌃+上記",    description: "クリップボードに保存"),
        ]),
        ShortcutGroup(category: "テキスト編集（共通）", shortcuts: [
            Shortcut(command: "⌃A",        description: "行頭へ"),
            Shortcut(command: "⌃E",        description: "行末へ"),
            Shortcut(command: "⌥←",        description: "1単語左へ"),
            Shortcut(command: "⌥→",        description: "1単語右へ"),
            Shortcut(command: "⌘←",        description: "行頭へ（エディタ）"),
            Shortcut(command: "⌘→",        description: "行末へ（エディタ）"),
            Shortcut(command: "⌥⌫",        description: "1単語削除"),
            Shortcut(command: "⌃K",        description: "カーソル以降削除"),
        ]),
    ] }
}
