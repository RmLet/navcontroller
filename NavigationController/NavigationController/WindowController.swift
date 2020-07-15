//
//  WindowController.swift
//  NavigationController
//
//  Created by отмеченные on 14.05.2020.
//  Copyright © 2020 отмеченные. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    convenience init() {
        self.init(windowNibName:"WindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        let navigationController = NavigationController(rootViewController: OtherContoller())
        window?.contentViewController = navigationController
    }
}


