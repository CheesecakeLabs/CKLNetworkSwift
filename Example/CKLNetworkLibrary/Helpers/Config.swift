//
//  Config.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 08/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation

// MARK: - Config.plist Entries

struct Config {
    
    // MARK: - Attributes
    
    /// Used for requests on  server
    lazy var baseURL: String = {
        return configKey(key: "urlBase")
    }()
    
    // MARK: - Custom methods
    
    private func configKey(key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any],
            let value = dictionary[key] as? String else {
                return ""
        }
        return value
    }
}
