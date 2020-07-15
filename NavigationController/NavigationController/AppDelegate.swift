//
//  AppDelegate.swift
//  NavigationController
//
//  Created by отмеченные on 14.05.2020.
//  Copyright © 2020 отмеченные. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!
    let windowController = WindowController()
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        windowController.showWindow(nil)
    }
}

