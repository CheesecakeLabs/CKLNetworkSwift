//
//  NSObject+Extension.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 08/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

