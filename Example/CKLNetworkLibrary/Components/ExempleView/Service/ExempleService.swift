//
//  ExempleService.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 08/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation
import CKLNetworkLibrary

protocol ExempleServiceProtocol: AnyObject {
    
    typealias CompletionResponseTest = ((Response<ResponseTest>) -> Void)
    
    func fethAnswer(completion: @escaping CompletionResponseTest)
}

final class ExempleService: ExempleServiceProtocol {
 
    // MARK: - Attributes
    
    private let network = CKLNetwork<ExempleResources>()
    
    // MARK: - Request
    
    func fethAnswer(completion: @escaping CompletionResponseTest) {
        let resource: ExempleResources = .fetchTest
        network.makeRequest(request: resource, completion)
    }
}
