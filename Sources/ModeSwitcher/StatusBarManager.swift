import AppKit
import Foundation

class StatusBarManager {
    var statusBarItem: NSStatusItem!
    let darkModeManager = DarkModeManager()

    func updateStatusBarIcon() {
        let isDarkMode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
        if let button = statusBarItem.button {
            if #available(macOS 11.0, *) {
                button.image = NSImage(systemSymbolName: isDarkMode ? "moon.fill" : "sun.max.fill", accessibilityDescription: isDarkMode ? "Dark Mode" : "Light Mode")
            } else {
                if let image = NSImage(named: NSImage.Name(isDarkMode ? "moonImage" : "sunImage")) {
                    button.image = image
                }
            }
        }
    }

    func showContextMenu() {
        let menu = NSMenu()
        menu.addItem(withTitle: "Quit", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "q")
        statusBarItem.menu = menu
        statusBarItem.button?.performClick(nil)
        statusBarItem.menu = nil 
    }
    
    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton?) {
        guard let event = NSApp.currentEvent else { return }

        if event.type == .rightMouseUp {
            showContextMenu()
        } else if event.type == .leftMouseUp {
            darkModeManager.toggleDarkMode()
            updateStatusBarIcon()
        }
    }

}