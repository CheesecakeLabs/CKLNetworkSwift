//
//  CKLErrorCustom.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 06/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation

public protocol CKLErrorBusinessProtocol {
    var code: Int { get }
    var detail: String { get }
}

public struct CKLErrorBusiness: CKLErrorBusinessProtocol, Decodable {
    public var code: Int = 0
    public var detail: String = ""
}


/// we are working with 4 types of errors, which are divided into: custom, business, generic, noIntern and authentication.
public enum CKLErrorCustom: Error {
    
    case custom(message: String)
    case business(CKLErrorBusiness)
    case generic
    case noInternet
    case authentication
    
    /// return the error message. You can set generic, noInternet and authentication error in the config section. Custom and business errors are returned from the server.
    public var CKLMessage: String {
        switch self {
        case .custom(let message):
            return message
        case .business(let data):
            return data.detail
        case .generic:
            return genericErrorMessage
        case .noInternet:
            return noInternetErrorMessage
        case .authentication:
            return authenticationErrorMessage
        }
    }
}
