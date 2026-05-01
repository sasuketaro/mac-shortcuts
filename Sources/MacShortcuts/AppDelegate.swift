// ─────────────────────────────────────────────
// AppDelegate.swift
// アプリ全体のライフサイクル（起動・終了）を管理するクラス。
// ・起動時にウィンドウを作成して画面右 1/4 に配置する
// ・他のアプリがアクティブになったことを検知して対象アプリを更新する
// ─────────────────────────────────────────────
import Cocoa
import SwiftUI
import ApplicationServices

// NSApplicationDelegate : macOS アプリの「管理担当者」を定義するプロトコル
// NSObject を継承することで Objective-C との橋渡しが可能になる
class AppDelegate: NSObject, NSApplicationDelegate {

    // アプリ自身のウィンドウを保持する変数（! = 後で必ず値が入る保証）
    var window: NSWindow!

    // アプリの切り替えを監視するオブジェクト（後で解除するために保持しておく）
    private var appObserver: Any?

    // ─── アプリ起動直後に自動的に呼ばれる ───
    func applicationDidFinishLaunching(_ notification: Notification) {
        requestAccessibility() // アクセシビリティ権限を確認・要求
        setupWindow()          // ウィンドウを作成・配置
        startMonitoring()      // 他アプリの切り替え監視を開始
    }

    // ─── アクセシビリティ権限の要求 ───
    // 他のアプリのウィンドウを操作するために macOS の許可が必要。
    // 初回起動時にシステムのダイアログが表示される。
    private func requestAccessibility() {
        // kAXTrustedCheckOptionPrompt : 未許可の場合にダイアログを表示するオプション
        let opts = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as String: true] as CFDictionary
        AXIsProcessTrustedWithOptions(opts)
    }

    // ─── ウィンドウの作成と配置 ───
    private func setupWindow() {
        // メイン画面が取得できなければ何もしない（guard = 条件を満たさなければ即return）
        guard let screen = NSScreen.main else { return }

        // visibleFrame : メニューバーと Dock を除いた使用可能な画面領域
        let vf = screen.visibleFrame

        // 幅を画面の 1/4 に設定（floor = 小数点以下を切り捨て）
        let width = floor(vf.width / 4)

        // ContentView（UI）に AppState（状態管理）を渡して組み合わせる
        let contentView = ContentView().environmentObject(AppState.shared)

        // NSWindow : macOS のウィンドウを作成する
        // x 座標を「画面右端 − 幅」にすることで右 1/4 に配置する
        window = NSWindow(
            contentRect: NSRect(x: vf.maxX - width, y: vf.minY, width: width, height: vf.height),
            styleMask: [.titled, .closable, .miniaturizable], // タイトルバー・閉じる・最小化ボタンあり
            backing: .buffered,   // 描画をバッファリングする（標準的な設定）
            defer: false          // 今すぐウィンドウを作成する
        )
        window.title = "Mac Shortcuts"

        // SwiftUI の View を AppKit のウィンドウに埋め込む橋渡し役
        window.contentView = NSHostingView(rootView: contentView)

        // .floating : 他のウィンドウより常に手前に表示する
        window.level = .floating

        // 全てのデスクトップ（Spaces）で表示し、ウィンドウを固定する
        window.collectionBehavior = [.canJoinAllSpaces, .stationary]

        // ウィンドウを閉じてもメモリから解放しない（再表示できるよう保持する）
        window.isReleasedWhenClosed = false

        // ウィンドウを最前面に表示してキーウィンドウにする
        window.makeKeyAndOrderFront(nil)
    }

    // ─── 他アプリのアクティブ切り替えを監視 ───
    private func startMonitoring() {
        // 自分自身のプロセスID（対象アプリと自分自身を区別するために使う）
        let ownPid = ProcessInfo.processInfo.processIdentifier

        // NSWorkspace.shared.notificationCenter : macOS システム全体のイベントを受け取る
        // didActivateApplicationNotification : どれかのアプリが前面に出た瞬間に発火する
        appObserver = NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didActivateApplicationNotification,
            object: nil,
            queue: .main // UI の更新はメインスレッドで行う
        ) { notification in
            // アクティブになったアプリの情報を取り出す
            guard let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
                  app.processIdentifier != ownPid,  // 自分自身は無視
                  app.activationPolicy == .regular   // ドックに表示される通常アプリのみ対象
            else { return }

            // 対象アプリの情報とショートカット一覧を更新する
            AppState.shared.updateTargetApp(app)
            // 対象アプリのウィンドウを左 3/4 に移動する
            WindowManager.shared.positionTargetApp(app)
        }
    }

    // ─── アプリ終了直前に呼ばれる ───
    func applicationWillTerminate(_ notification: Notification) {
        // 監視オブジェクトを解除してメモリリークを防ぐ
        if let obs = appObserver {
            NSWorkspace.shared.notificationCenter.removeObserver(obs)
        }
    }

    // 最後のウィンドウが閉じられたらアプリを終了する
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }
}
