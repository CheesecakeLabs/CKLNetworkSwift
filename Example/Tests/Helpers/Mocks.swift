//
//  Mocks.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 07/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation
import CKLNetwork

final class Mocks {
    
    static func responseTest() -> ResponseTest {
        FileDecoder.decode(resource: .responseTest)
    }
    
    static func responseEmpty() -> ResultEmpty {
        FileDecoder.decode(resource: .responseEmpty)
    }
}
