//
//  ExempleResources.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 08/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation
import Alamofire
import CKLNetwork

enum ExempleResources {
    case fetchTest
}

extension ExempleResources: CKLRequestable {
    
    /// if you need to change the authorization, uncomment.
    /// Default key authorization  is  `Authorization`, you can change using setKeyNameAuthorization, and `Token` is provide in setToken
   /* var nameKeyAuthorization: String {
        "X-CMC_PRO_API_KEY"
    }
   
    var tokenAuthorization: String {
        "token"
    }
    */
    
    var baseURL: String {
          var config = Config()
          return config.baseURL
    }
 
    var method: HTTPMethod {
        switch self {
        case .fetchTest:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchTest:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .fetchTest:
            return "response.json"
        }
    }
}
