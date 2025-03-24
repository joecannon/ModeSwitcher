import AppKit
import Foundation

class AutoLaunch {

func createAutoLaunchPlist() {
    let fileManager = FileManager.default
    let launchAgentsPath = fileManager.homeDirectoryForCurrentUser.appendingPathComponent("Library/LaunchAgents")
    let plistPath = launchAgentsPath.appendingPathComponent("com.joecannon.ModeSwitcher.plist")
    let appPath = "/Applications/ModeSwitcher.app"
    
    if fileManager.fileExists(atPath: plistPath.path) {
        print("Launch Agent already exists.")
        return
    }

    let plistContent: [String: Any] = [
        "Label": "com.joecannon.ModeSwitcher",
        "ProgramArguments": [appPath],
        "RunAtLoad": true
    ]
    
    do {
        let plistData = try PropertyListSerialization.data(fromPropertyList: plistContent, format: .xml, options: 0)

        try plistData.write(to: plistPath)

        let task = Process()
        task.launchPath = "/bin/launchctl"
        task.arguments = ["load", plistPath.path]
        task.launch()
        task.waitUntilExit()
        
        if task.terminationStatus == 0 {
            print("Launch Agent loaded successfully.")
        } else {
            print("Failed to load Launch Agent.")
        }
    } catch {
        print("Error creating plist file: \(error)")
    }
}

}