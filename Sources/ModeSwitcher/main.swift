import AppKit
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!

    func toggleDarkMode() {
        let script = """
        tell application "System Events"
            tell appearance preferences
                set dark mode to not dark mode
            end tell
        end tell
        """

        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            scriptObject.executeAndReturnError(&error)
            if let error = error {
                print("Error toggling dark mode: \(error)")
            }
        } else {
            print("Error creating AppleScript object.")
        }
        updateStatusBarIcon()
    }
    
    func showContextMenu() {
        let menu = NSMenu()
        menu.addItem(withTitle: "Quit", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "q")
        statusBarItem.menu = menu
        statusBarItem.button?.performClick(nil)
        statusBarItem.menu = nil 
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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        updateStatusBarIcon()
        if let button = statusBarItem.button {
            button.target = self
            button.action = #selector(statusBarButtonClicked(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp]) // Listen for both left and right clicks
        }

    }

    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton?) {
        guard let event = NSApp.currentEvent else { return }

        if event.type == .rightMouseUp {
            showContextMenu()
        } else if event.type == .leftMouseUp {
            toggleDarkMode()
        }
    }

}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()