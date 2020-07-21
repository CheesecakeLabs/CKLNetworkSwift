//
//  FileDecoder.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 07/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation

enum JSONFiles: String {
    case
    responseTest,
    responseEmpty
}

final class FileDecoder {

    static func decode<T: Decodable>(resource: JSONFiles) -> T {
        let decoder = JSONDecoder()
        let bundle = Bundle.main

        guard let jsonUrl = bundle.url(forResource: resource.rawValue, withExtension: "json") else {
            fatalError("Error loading JSON")
        }

        guard let jsonData = try? Data(contentsOf: jsonUrl) else {
            fatalError("Failed to parse JSON from URL")
        }

        guard let response = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("Failed to decode JSON")
        }

        return response
    }
}

