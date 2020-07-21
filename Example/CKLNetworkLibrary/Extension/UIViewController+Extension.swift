//
//  UIViewController+Extension.swift
//  CKLNetworkLibrary_Example
//
//  Created by Ricardo Cherobin on 14/07/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func isKindType<T: AnyObject>(of: T.Type) -> T? {
        return self as? T
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}
