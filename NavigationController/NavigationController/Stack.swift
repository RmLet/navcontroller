//
//  Stack.swift
//  NavigationController
//
//  Created by отмеченные on 14.05.2020.
//  Copyright © 2020 отмеченные. All rights reserved.
//

import Foundation


class Stack<T>: NSObject {
    fileprivate var top: StackItem<T>?
    fileprivate var length: UInt = 0
   
    var topValue: T? {
        get {
            return self.top?.v
        }
    }
    
    var _length: UInt {
        get {
            return self.length
        }
    }
    
    func push(_ object: T) -> Void {
        let item = StackItem(object)
        item.n = self.top
        self.top = item
        self.length += 1
    }
    
    func pop() -> T? {
        guard self.top != nil else {
            NSException(name: NSExceptionName.internalInconsistencyException, reason: "пустой стэк", userInfo: nil).raise()
            return nil
        }
        let retVal = self.top?.v
        self.top = self.top?.n
        self.length -= 1
        return retVal
    }
}
