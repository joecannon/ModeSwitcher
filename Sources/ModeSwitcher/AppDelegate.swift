import AppKit
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    
    let AppStatusBar = StatusBarManager()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        AppStatusBar.statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        AppStatusBar.updateStatusBarIcon()
        if let button = AppStatusBar.statusBarItem.button {
            button.target = self
            button.action = #selector(AppStatusBar.statusBarButtonClicked(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }

}
