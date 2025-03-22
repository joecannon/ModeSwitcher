import AppKit
import Foundation

class StatusBarManager {
    var statusBarItem: NSStatusItem!
    var darkModeManager = DarkModeManager()

    init() {
        setupStatusBarItem()
    }

    func setupStatusBarItem() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusBarItem.button {
            
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
            button.action = #selector(statusBarButtonClicked(_:))
            button.target = self

        }
        updateStatusBarIcon() 
    }

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

    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton?) {
        if let event = NSApp.currentEvent {
            if event.type == NSEvent.EventType.rightMouseUp {
                let menu = NSMenu()
                menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
                statusBarItem.menu = menu
                statusBarItem.button?.performClick(nil)
                statusBarItem.menu = nil
            } else if event.type == NSEvent.EventType.leftMouseUp {
                darkModeManager.toggleDarkMode()
                updateStatusBarIcon()
            }
        }
    }
}