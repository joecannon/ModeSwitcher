import AppKit
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    
    let appStatusBar = StatusBarManager()
    let AutoLaunchInstance = AutoLaunch()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        appStatusBar.updateStatusBarIcon()
        AutoLaunchInstance.createAutoLaunchPlist()
    }

}
