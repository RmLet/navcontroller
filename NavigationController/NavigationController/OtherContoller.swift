//
//  OtherContoller.swift
//  NavigationController
//
//  Created by отмеченные on 14.05.2020.
//  Copyright © 2020 отмеченные. All rights reserved.
//

import Cocoa

extension NSColor {
    static func random_color() -> CGColor{
        return Self.init(red: CGFloat(arc4random_uniform(63)) / 63.0 + 0.5, green: CGFloat(arc4random_uniform(63)) / 63.0 + 0.5, blue: CGFloat(arc4random_uniform(63)) / 63.0 + 0.5, alpha: 1).cgColor
    }
}



class OtherContoller: NSViewController, NavigationControllerDelegate {
    weak var navigationController: NavigationController?
    @IBOutlet weak var stack_count: NSTextFieldCell!
    
    @IBAction func remove(_ sender: Any) {
        let _ = self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func add(_ sender: Any) {
        self.navigationController?.pushViewController(OtherContoller(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.random_color()
        self.stack_count.title = "stack count is \(self.navigationController!.viewControllers_count)"
    }
}
