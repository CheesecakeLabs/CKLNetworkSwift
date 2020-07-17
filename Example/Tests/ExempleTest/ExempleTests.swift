//
//  ExempleTests.swift
//  CKLNetworkLibrary_Tests
//
//  Created by Ricardo Cherobin on 14/07/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import CKLNetworkLibrary

class ExempleTests: XCTestCase {
    
    func testExempleSuccess() {
        let service = ExempleSuccessStub()
        let viewModel = ExempleViewModel(service: service)
        viewModel.fetchExempleData()
        XCTAssertNotNil(viewModel.getTest())
    }
    
    func testExempleForbiddenFailure() {
        let service = ExempleErrorForbiddenStub()
        let viewModel = ExempleViewModel(service: service)
        viewModel.fetchExempleData()
        XCTAssertEqual(viewModel.getStatusCode(), HTTPStatusCode.forbidden)
    }
}
