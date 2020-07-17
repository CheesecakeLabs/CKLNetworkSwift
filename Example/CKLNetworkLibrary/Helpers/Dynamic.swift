//
//  Dynamic.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 08/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    var hasListener: Bool {
        return self.listener != nil
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func fire() {
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
