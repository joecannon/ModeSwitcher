import AppKit
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {

    let appStatusBar = StatusBarManager()
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        appStatusBar.updateStatusBarIcon() // Update the status bar icon
    }
}