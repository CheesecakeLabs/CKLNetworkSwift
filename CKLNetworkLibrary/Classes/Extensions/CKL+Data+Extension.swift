//
//  CKL+Data+Extension.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 06/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation

extension Data {
    
    func CKLDecode<T: Decodable>() -> T? {
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: self)
            return object
        } catch {
            return nil
        }
    }
}
