//
//  NavigationController.swift
//  NavigationController
//
//  Created by отмеченные on 14.05.2020.
//  Copyright © 2020 отмеченные. All rights reserved.
//

import Cocoa



protocol NavigationControllerDelegate {
    var navigationController: NavigationController? {get set}
}


class NavigationController: NSViewController {
    fileprivate(set) var rootViewController: NSViewController
    fileprivate var _activeView: NSView?
    fileprivate var _addRootViewOnceToken: Int = 0
    fileprivate var _stack: Stack<NSViewController> = Stack<NSViewController>()
    private lazy var __addRootViewOnce: () = {
        self._activeView = self.rootViewController.view
        self.addActiveViewAnimated(false, subtype: nil)
    }()
    
    var viewControllers_count: String {
        get {
            return String(self._stack._length)
        }
    }
    
    
    init?(rootViewController: NSViewController?) {
        self.rootViewController = rootViewController!
        super.init(nibName: nil, bundle: nil)
        if var rootViewController = self.rootViewController as? NavigationControllerDelegate {
            rootViewController.navigationController = self
        } else {
            NSException(name: NSExceptionName.internalInconsistencyException, reason: "несоответствие протоколу NavigationControllerDelegate", userInfo: nil).raise()
            return nil
        }
    }
    
    required init?(coder: NSCoder) {
        self.rootViewController = NSViewController()
        super.init(coder: coder)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        _ = self.__addRootViewOnce
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
         self.view.wantsLayer = true
     }
    
    override func loadView() {
        self.view = NSView()
        self.view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 300))
    }
    
    func pushViewController(_ viewController: NSViewController, animated: Bool) {
        self._activeView?.removeFromSuperview()
        self._stack.push(viewController)
        if var viewControllerWithNav = viewController as? NavigationControllerDelegate {
            viewControllerWithNav.navigationController = self
        }
        self._activeView = viewController.view
        self.addActiveViewAnimated(animated, subtype: NSApp.userInterfaceLayoutDirection == .leftToRight ? CATransitionSubtype.fromRight.rawValue : CATransitionSubtype.fromLeft.rawValue)
    }
    
    func popViewControllerAnimated(_ animated: Bool) -> NSViewController? {
        guard self._stack._length != 0 else {return nil}
        self._activeView?.removeFromSuperview()
        let retVal = self._stack.pop()
        self._activeView = self._stack.topValue?.view
        if self._activeView == nil {
            self._activeView = self.rootViewController.view
        }
        self.addActiveViewAnimated(animated, subtype: NSApp.userInterfaceLayoutDirection == .leftToRight ? CATransitionSubtype.fromLeft.rawValue : CATransitionSubtype.fromRight.rawValue)
        return retVal
    }
    
    func popToRootViewControllerAnimated(_ animated: Bool) -> [NSViewController]? {
        guard self._stack._length != 0 else {return nil}
        var retVal = [NSViewController]()
        for _ in 1...self._stack._length {
            if let vc = self.popViewControllerAnimated(animated) {
                retVal.append(vc)
            }
        }
        return retVal
    }

    fileprivate func addActiveViewAnimated(_ animated: Bool, subtype: String?) {
        if animated {
            self.view.animator().addSubview(self._activeView!)
            self.setupConstraints()
        } else {
            self.view.addSubview(self._activeView!)
            self.setupConstraints()
        }
    }
}


extension NavigationController {
    fileprivate func setupConstraints() {
        self._activeView!.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self._activeView!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self._activeView!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self._activeView!.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self._activeView!.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}



