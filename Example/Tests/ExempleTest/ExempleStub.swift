//
//  ExempleStub.swift
//  CKLNetworkLibrary_Example
//
//  Created by Ricardo Cherobin on 14/07/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CKLNetworkLibrary

final class ExempleSuccessStub: ExempleServiceProtocol {
    func fethAnswer(completion: @escaping CompletionResponseTest) {
        completion(.success(Mocks.responseTest(), statusCode: HTTPStatusCode.ok))
    }
}

final class ExempleErrorForbiddenStub: ExempleServiceProtocol {
    func fethAnswer(completion: @escaping CompletionResponseTest) {
        completion(.failure(error: .generic, statusCode: HTTPStatusCode.forbidden))
    }
}
