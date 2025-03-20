import Foundation

class DarkModeManager {
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
    }
}