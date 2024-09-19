//
//  AppDelegate.swift
//  FamilyPicMemoryGame
//
//  Created by Nimrod Gruber on 12/09/2024.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationShouldRestoreApplicationState(_ application: NSApplication) -> Bool {
        return false
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
