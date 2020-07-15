//
//  StackItem.swift
//  NavigationController
//
//  Created by отмеченные on 14.05.2020.
//  Copyright © 2020 отмеченные. All rights reserved.
//

import Foundation

class StackItem<T> : NSObject {
    var v: T
    var n: StackItem<T>?
    init(_ v: T) {
        self.v = v
    }
}
