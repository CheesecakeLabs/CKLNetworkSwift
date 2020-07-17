//
//  CKL+Encodable+Extension.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 06/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation

extension Encodable {
    
    func CKLToJson() -> [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
