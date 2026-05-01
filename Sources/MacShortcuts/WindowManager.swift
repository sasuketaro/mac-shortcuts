// ─────────────────────────────────────────────
// WindowManager.swift
// ウィンドウの位置とサイズを制御するクラス。
// ・本アプリ自身を画面右 1/4 に配置する
// ・対象アプリのウィンドウを画面左 3/4 に配置する
//
// ※ macOS には2種類の座標系があり、変換が必要：
//   NSScreen（AppKit）: 左下が原点、Y は上向き
//   AXUIElement（アクセシビリティ API）: 左上が原点、Y は下向き
// ─────────────────────────────────────────────
import Cocoa
import ApplicationServices

class WindowManager {
    // アプリ内でただ一つのインスタンスを共有する（シングルトン）
    static let shared = WindowManager()
    private init() {}

    // ─── 本アプリを画面右 1/4 に配置 ───
    // NSWindow を直接操作するため AppKit の座標系（左下原点）をそのまま使える
    func positionThisApp(window: NSWindow) {
        guard let screen = NSScreen.main else { return }
        let vf = screen.visibleFrame   // メニューバー・Dock を除いた使用可能領域
        let width = floor(vf.width / 4) // 幅 = 画面の 1/4
        // x = 右端 − 幅 → ウィンドウが右端に来る
        let frame = NSRect(x: vf.maxX - width, y: vf.minY, width: width, height: vf.height)
        window.setFrame(frame, display: true, animate: false)
    }

    // ─── 対象アプリを画面左 3/4 に配置（最大4回リトライ） ───
    // 起動直後はウィンドウがまだ存在しない場合があるため、少し待ってリトライする
    func positionTargetApp(_ app: NSRunningApplication) {
        attempt(app, remaining: 4, delay: 0)
    }

    // ─── リトライを管理する再帰関数 ───
    // remaining : 残りリトライ回数
    // delay     : 次の試行まで待つ秒数
    private func attempt(_ app: NSRunningApplication, remaining: Int, delay: TimeInterval) {
        guard remaining > 0 else { return } // 試行回数が尽きたら終了

        // asyncAfter : delay 秒後にメインスレッドで処理を実行する
        // [weak self] : self への弱参照。クラスが解放済みでもクラッシュしないようにする
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self else { return }
            // 配置に失敗したら 0.6 秒後に再挑戦
            if !self.applyFrame(to: app) {
                self.attempt(app, remaining: remaining - 1, delay: 0.6)
            }
        }
    }

    // ─── アクセシビリティ API で対象アプリのウィンドウを実際に動かす ───
    // @discardableResult : 戻り値（Bool）を使わなくてもコンパイラが警告を出さないようにする
    @discardableResult
    private func applyFrame(to app: NSRunningApplication) -> Bool {
        guard let screen = NSScreen.main else { return false }

        // AXUIElementCreateApplication : アクセシビリティ API でアプリを操作する「ハンドル」を取得
        let axApp = AXUIElementCreateApplication(app.processIdentifier)

        // kAXWindowsAttribute : そのアプリが持つウィンドウ一覧を取得するキー
        var ref: CFTypeRef?
        guard AXUIElementCopyAttributeValue(axApp, kAXWindowsAttribute as CFString, &ref) == .success,
              let windows = ref as? [AXUIElement],
              let window = windows.first // 最前面のウィンドウを対象にする
        else { return false }

        let sf = screen.frame        // 画面全体のサイズ（メニューバー含む）
        let vf = screen.visibleFrame // 使用可能領域（メニューバー・Dock を除く）

        // ── 座標変換（NSScreen 左下原点 → AX 左上原点）──
        // メニューバーの高さ = 全体の高さ − 使用可能領域の上端
        let menuBarH = sf.height - vf.maxY

        // AX 座標での配置：x=0（左端）、y=メニューバー分だけ下
        var pos  = CGPoint(x: 0, y: menuBarH)
        // 幅 = 画面全体の 3/4、高さ = 使用可能領域の高さ
        var size = CGSize(width: floor(sf.width * 3 / 4), height: vf.height)

        // CGPoint / CGSize を AX API が受け取れる AXValue 型にラップする
        guard let posVal  = AXValueCreate(.cgPoint, &pos),
              let sizeVal = AXValueCreate(.cgSize,  &size) else { return false }

        // ウィンドウの位置とサイズを設定する
        AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, posVal)
        AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString,     sizeVal)
        return true
    }
}
