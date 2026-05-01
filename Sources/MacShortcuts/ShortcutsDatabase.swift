import AppKit

class ShortcutsDatabase {
    static let shared = ShortcutsDatabase()

    private init() {}

    func shortcuts(for app: NSRunningApplication) -> [ShortcutGroup] {
        let id = app.bundleIdentifier?.lowercased() ?? ""
        let name = app.localizedName?.lowercased() ?? ""

        switch true {
        case id.contains("safari") || name == "safari":
            return safari
        case id.contains("chrome") || name.contains("chrome"):
            return chrome
        case id.contains("firefox") || name.contains("firefox"):
            return firefox
        case id.contains("terminal") || name == "terminal":
            return terminal
        case id.contains("vscode") || name.contains("visual studio code") || name == "code":
            return vscode
        case id.contains("finder") || name == "finder":
            return finder
        case id.contains("slack") || name == "slack":
            return slack
        case id.contains("xcode") || name == "xcode":
            return xcode
        default:
            return generic
        }
    }

    // MARK: Safari
    private var safari: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "Space",   description: "下スクロール"),
            Shortcut(command: "⇧Space",  description: "上スクロール"),
            Shortcut(command: "⌘↓",      description: "ページ末尾"),
            Shortcut(command: "⌘↑",      description: "ページ先頭"),
            Shortcut(command: "↑ / ↓",   description: "1行スクロール"),
        ]),
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘[",      description: "前のページ"),
            Shortcut(command: "⌘]",      description: "次のページ"),
            Shortcut(command: "⌘L",      description: "アドレスバー選択"),
            Shortcut(command: "⌘F",      description: "ページ内検索"),
            Shortcut(command: "⌘R",      description: "再読み込み"),
            Shortcut(command: "⌘⇧R",     description: "リーダー表示"),
        ]),
        ShortcutGroup(category: "タブ操作", shortcuts: [
            Shortcut(command: "⌘T",      description: "新規タブ"),
            Shortcut(command: "⌘W",      description: "タブを閉じる"),
            Shortcut(command: "⌘⇧T",     description: "閉じたタブを開く"),
            Shortcut(command: "⌘⇧]",     description: "右のタブへ"),
            Shortcut(command: "⌘⇧[",     description: "左のタブへ"),
            Shortcut(command: "⌘1〜9",    description: "タブ番号で移動"),
        ]),
        ShortcutGroup(category: "その他", shortcuts: [
            Shortcut(command: "⌘+",      description: "ズームイン"),
            Shortcut(command: "⌘-",      description: "ズームアウト"),
            Shortcut(command: "⌘0",      description: "ズームリセット"),
            Shortcut(command: "⌘D",      description: "ブックマーク追加"),
            Shortcut(command: "⌘N",      description: "新規ウィンドウ"),
        ]),
    ] }

    // MARK: Chrome
    private var chrome: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "Space",   description: "下スクロール"),
            Shortcut(command: "⇧Space",  description: "上スクロール"),
            Shortcut(command: "⌘↓",      description: "ページ末尾"),
            Shortcut(command: "⌘↑",      description: "ページ先頭"),
            Shortcut(command: "↑ / ↓",   description: "1行スクロール"),
        ]),
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘[",      description: "前のページ"),
            Shortcut(command: "⌘]",      description: "次のページ"),
            Shortcut(command: "⌘L",      description: "アドレスバー選択"),
            Shortcut(command: "⌘F",      description: "ページ内検索"),
            Shortcut(command: "⌘R",      description: "再読み込み"),
            Shortcut(command: "⌘⇧R",     description: "キャッシュ無視して再読込"),
        ]),
        ShortcutGroup(category: "タブ操作", shortcuts: [
            Shortcut(command: "⌘T",      description: "新規タブ"),
            Shortcut(command: "⌘W",      description: "タブを閉じる"),
            Shortcut(command: "⌘⇧T",     description: "閉じたタブを開く"),
            Shortcut(command: "⌘⇧]",     description: "右のタブへ"),
            Shortcut(command: "⌘⇧[",     description: "左のタブへ"),
            Shortcut(command: "⌘1〜8",    description: "タブ番号で移動"),
            Shortcut(command: "⌘9",      description: "最後のタブへ"),
        ]),
        ShortcutGroup(category: "デベロッパー", shortcuts: [
            Shortcut(command: "⌘⌥I",     description: "デベロッパーツール"),
            Shortcut(command: "⌘⌥J",     description: "コンソール"),
            Shortcut(command: "⌘U",      description: "ソースを表示"),
        ]),
    ] }

    // MARK: Firefox
    private var firefox: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "Space",   description: "下スクロール"),
            Shortcut(command: "⇧Space",  description: "上スクロール"),
            Shortcut(command: "⌘↓",      description: "ページ末尾"),
            Shortcut(command: "⌘↑",      description: "ページ先頭"),
            Shortcut(command: "↑ / ↓",   description: "1行スクロール"),
        ]),
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘[",      description: "前のページ"),
            Shortcut(command: "⌘]",      description: "次のページ"),
            Shortcut(command: "⌘L",      description: "アドレスバー選択"),
            Shortcut(command: "⌘F",      description: "ページ内検索"),
            Shortcut(command: "⌘R",      description: "再読み込み"),
        ]),
        ShortcutGroup(category: "タブ操作", shortcuts: [
            Shortcut(command: "⌘T",      description: "新規タブ"),
            Shortcut(command: "⌘W",      description: "タブを閉じる"),
            Shortcut(command: "⌘⇧T",     description: "閉じたタブを開く"),
            Shortcut(command: "⌘⌥→",     description: "右のタブへ"),
            Shortcut(command: "⌘⌥←",     description: "左のタブへ"),
        ]),
    ] }

    // MARK: Terminal
    private var terminal: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "⌘↑",      description: "上スクロール"),
            Shortcut(command: "⌘↓",      description: "下スクロール"),
            Shortcut(command: "Fn+↑",    description: "1ページ上へ"),
            Shortcut(command: "Fn+↓",    description: "1ページ下へ"),
            Shortcut(command: "⌘Home",   description: "スクロール先頭"),
            Shortcut(command: "⌘End",    description: "スクロール末尾"),
        ]),
        ShortcutGroup(category: "カーソル移動", shortcuts: [
            Shortcut(command: "⌃A",      description: "行頭へ"),
            Shortcut(command: "⌃E",      description: "行末へ"),
            Shortcut(command: "⌥←",      description: "1単語左へ"),
            Shortcut(command: "⌥→",      description: "1単語右へ"),
        ]),
        ShortcutGroup(category: "編集", shortcuts: [
            Shortcut(command: "⌃U",      description: "行を削除"),
            Shortcut(command: "⌃K",      description: "カーソル以降削除"),
            Shortcut(command: "⌃W",      description: "1単語削除"),
            Shortcut(command: "⌃Y",      description: "貼り付け (yank)"),
        ]),
        ShortcutGroup(category: "プロセス", shortcuts: [
            Shortcut(command: "⌃C",      description: "実行を中断"),
            Shortcut(command: "⌃Z",      description: "バックグラウンドへ"),
            Shortcut(command: "⌃D",      description: "EOF / ログアウト"),
            Shortcut(command: "⌃R",      description: "コマンド履歴検索"),
            Shortcut(command: "⌃L",      description: "画面クリア"),
        ]),
        ShortcutGroup(category: "タブ操作", shortcuts: [
            Shortcut(command: "⌘T",      description: "新規タブ"),
            Shortcut(command: "⌘W",      description: "タブを閉じる"),
            Shortcut(command: "⌘⇧]",     description: "右のタブへ"),
            Shortcut(command: "⌘⇧[",     description: "左のタブへ"),
            Shortcut(command: "⌘K",      description: "ターミナルをクリア"),
        ]),
    ] }

    // MARK: VS Code
    private var vscode: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "⌃↑",      description: "上にスクロール"),
            Shortcut(command: "⌃↓",      description: "下にスクロール"),
            Shortcut(command: "⌘↑",      description: "ファイル先頭"),
            Shortcut(command: "⌘↓",      description: "ファイル末尾"),
            Shortcut(command: "⌘G",      description: "指定行へジャンプ"),
        ]),
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘P",      description: "ファイル検索"),
            Shortcut(command: "⌘⇧P",     description: "コマンドパレット"),
            Shortcut(command: "⌘F",      description: "ファイル内検索"),
            Shortcut(command: "⌘⇧F",     description: "フォルダ全体検索"),
            Shortcut(command: "⌃-",      description: "前の位置へ戻る"),
            Shortcut(command: "⌃⇧-",     description: "次の位置へ進む"),
            Shortcut(command: "F12",      description: "定義へジャンプ"),
            Shortcut(command: "⌥F12",     description: "定義をプレビュー"),
        ]),
        ShortcutGroup(category: "編集", shortcuts: [
            Shortcut(command: "⌘/",      description: "コメント切替"),
            Shortcut(command: "⌘D",      description: "同じ単語を選択"),
            Shortcut(command: "⌘⇧K",     description: "行を削除"),
            Shortcut(command: "⌥↑/↓",    description: "行を移動"),
            Shortcut(command: "⌥⇧↑/↓",   description: "行をコピー"),
            Shortcut(command: "⌘⏎",      description: "下に行を挿入"),
            Shortcut(command: "⌘⇧⏎",     description: "上に行を挿入"),
        ]),
        ShortcutGroup(category: "ウィンドウ", shortcuts: [
            Shortcut(command: "⌘B",      description: "サイドバー切替"),
            Shortcut(command: "⌘J",      description: "パネル切替"),
            Shortcut(command: "⌘\\",     description: "エディタを分割"),
            Shortcut(command: "⌘1/2/3",  description: "エディタグループ移動"),
            Shortcut(command: "⌘⇧E",     description: "エクスプローラー"),
        ]),
    ] }

    // MARK: Finder
    private var finder: [ShortcutGroup] { [
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘↑",      description: "上位フォルダへ"),
            Shortcut(command: "⌘↓",      description: "フォルダを開く"),
            Shortcut(command: "⌘⇧G",     description: "フォルダへ移動"),
            Shortcut(command: "⌘[",      description: "前のフォルダ"),
            Shortcut(command: "⌘]",      description: "次のフォルダ"),
            Shortcut(command: "⌘⇧H",     description: "ホームフォルダ"),
            Shortcut(command: "⌘⇧D",     description: "デスクトップ"),
            Shortcut(command: "⌘⇧A",     description: "アプリケーション"),
        ]),
        ShortcutGroup(category: "ファイル操作", shortcuts: [
            Shortcut(command: "Space",   description: "クイックルック"),
            Shortcut(command: "⌘O",      description: "開く"),
            Shortcut(command: "⌘Delete", description: "ゴミ箱へ移動"),
            Shortcut(command: "⌘⇧N",     description: "新規フォルダ"),
            Shortcut(command: "⌘I",      description: "情報を見る"),
            Shortcut(command: "⌘D",      description: "複製"),
            Shortcut(command: "⌘⌥V",     description: "移動して貼り付け"),
            Shortcut(command: "⌘⇧.",     description: "隠しファイル表示切替"),
        ]),
        ShortcutGroup(category: "表示", shortcuts: [
            Shortcut(command: "⌘1",      description: "アイコン表示"),
            Shortcut(command: "⌘2",      description: "リスト表示"),
            Shortcut(command: "⌘3",      description: "カラム表示"),
            Shortcut(command: "⌘4",      description: "ギャラリー表示"),
            Shortcut(command: "⌘F",      description: "検索"),
        ]),
    ] }

    // MARK: Slack
    private var slack: [ShortcutGroup] { [
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘K",      description: "チャンネル/DMに移動"),
            Shortcut(command: "⌘[",      description: "前のチャンネル"),
            Shortcut(command: "⌘]",      description: "次のチャンネル"),
            Shortcut(command: "⌘⇧M",     description: "アクティビティ"),
            Shortcut(command: "⌘⇧K",     description: "DM一覧"),
        ]),
        ShortcutGroup(category: "メッセージ", shortcuts: [
            Shortcut(command: "⏎",       description: "メッセージ送信"),
            Shortcut(command: "⌘⏎",      description: "改行"),
            Shortcut(command: "↑",       description: "直前メッセージを編集"),
            Shortcut(command: "⌘⇧\\",    description: "絵文字リアクション"),
            Shortcut(command: "⌘U",      description: "ファイルをアップロード"),
        ]),
        ShortcutGroup(category: "その他", shortcuts: [
            Shortcut(command: "⌘F",      description: "検索"),
            Shortcut(command: "⌘⇧Y",     description: "ステータス設定"),
            Shortcut(command: "⌘⌥M",     description: "マイク切替"),
            Shortcut(command: "⌘+/-",    description: "フォントサイズ"),
        ]),
    ] }

    // MARK: Xcode
    private var xcode: [ShortcutGroup] { [
        ShortcutGroup(category: "ナビゲーション", shortcuts: [
            Shortcut(command: "⌘⇧O",     description: "ファイルを開く"),
            Shortcut(command: "⌘L",      description: "指定行へジャンプ"),
            Shortcut(command: "⌃6",      description: "メソッド一覧"),
            Shortcut(command: "⌘⌃←/→",   description: "前後の履歴"),
            Shortcut(command: "⌘⌃↑/↓",   description: "ヘッダ/実装切替"),
        ]),
        ShortcutGroup(category: "編集", shortcuts: [
            Shortcut(command: "⌃I",      description: "インデント整形"),
            Shortcut(command: "⌘/",      description: "コメント切替"),
            Shortcut(command: "⌘⌥/",     description: "ドキュメントコメント"),
            Shortcut(command: "⌃⌘E",     description: "スコープ内リネーム"),
            Shortcut(command: "⌘D",      description: "行を複製"),
        ]),
        ShortcutGroup(category: "ビルド・実行", shortcuts: [
            Shortcut(command: "⌘R",      description: "ビルドして実行"),
            Shortcut(command: "⌘B",      description: "ビルド"),
            Shortcut(command: "⌘.",      description: "実行停止"),
            Shortcut(command: "⌘U",      description: "テスト実行"),
            Shortcut(command: "⌘⇧K",     description: "ビルドクリア"),
        ]),
        ShortcutGroup(category: "デバッグ", shortcuts: [
            Shortcut(command: "⌘\\",     description: "ブレークポイント切替"),
            Shortcut(command: "F6",       description: "ステップオーバー"),
            Shortcut(command: "F7",       description: "ステップイン"),
            Shortcut(command: "F8",       description: "ステップアウト"),
            Shortcut(command: "⌃⌘Y",     description: "実行再開"),
        ]),
    ] }

    // MARK: Generic
    private var generic: [ShortcutGroup] { [
        ShortcutGroup(category: "スクロール", shortcuts: [
            Shortcut(command: "Space",   description: "下スクロール"),
            Shortcut(command: "⇧Space",  description: "上スクロール"),
            Shortcut(command: "⌘↑",      description: "先頭へ"),
            Shortcut(command: "⌘↓",      description: "末尾へ"),
            Shortcut(command: "↑ / ↓",   description: "1行スクロール"),
        ]),
        ShortcutGroup(category: "基本操作", shortcuts: [
            Shortcut(command: "⌘C",      description: "コピー"),
            Shortcut(command: "⌘V",      description: "貼り付け"),
            Shortcut(command: "⌘X",      description: "切り取り"),
            Shortcut(command: "⌘Z",      description: "取り消す"),
            Shortcut(command: "⌘⇧Z",     description: "やり直す"),
            Shortcut(command: "⌘A",      description: "全選択"),
            Shortcut(command: "⌘F",      description: "検索"),
            Shortcut(command: "⌘S",      description: "保存"),
        ]),
        ShortcutGroup(category: "ウィンドウ", shortcuts: [
            Shortcut(command: "⌘W",      description: "ウィンドウを閉じる"),
            Shortcut(command: "⌘M",      description: "最小化"),
            Shortcut(command: "⌘H",      description: "隠す"),
            Shortcut(command: "⌘`",      description: "ウィンドウ切替"),
            Shortcut(command: "⌘Q",      description: "終了"),
        ]),
        ShortcutGroup(category: "スクリーンショット", shortcuts: [
            Shortcut(command: "⌘⇧3",     description: "全画面キャプチャ"),
            Shortcut(command: "⌘⇧4",     description: "範囲選択キャプチャ"),
            Shortcut(command: "⌘⇧5",     description: "スクリーンショットUI"),
        ]),
    ] }
}
