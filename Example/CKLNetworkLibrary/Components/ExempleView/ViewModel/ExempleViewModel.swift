//
//  ExempleViewModel.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 08/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation
import CKLNetwork

protocol ExempleViewModelProtocol {
    
    var isRequesting: Dynamic<Bool> { get }
    var reloadInfo: Dynamic<ResponseTest?> { get }
    var error: Dynamic<CKLErrorCustom?> { get }
    func fetchExempleData()
    func getStatusCode() -> HTTPStatusCode?
    func getTest() -> ResponseTest?
}

final class ExempleViewModel: ExempleViewModelProtocol {
    
    // MARK: - Attributes
    
    private var service: ExempleServiceProtocol
    private var coordinator: ExempleCoordinator?
    private var test:ResponseTest?
    private var statusCode:HTTPStatusCode?
    
    let isRequesting = Dynamic<Bool>(false)
    var reloadInfo = Dynamic<ResponseTest?>(nil)
    var error = Dynamic<CKLErrorCustom?>(nil)
    
    // MARK: - Life cycle
    
    init(coordinator: ExempleCoordinator? = nil, service: ExempleServiceProtocol = ExempleService()) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: - Services
    
    func fetchExempleData() {
        isRequesting.value = true
        
        service.fethAnswer { [weak self] result in
            switch result {
            case .success(let test, let statusCode):
                self?.test = test
                self?.statusCode = statusCode
                self?.reloadInfo.value = test
            case .failure(let error, let statusCode):
                self?.statusCode = statusCode
                self?.error.value = error
            }
            self?.reloadInfo.fire()
            self?.isRequesting.value = false
        }
    }
    
    // MARK: - Others
    
    func getStatusCode() -> HTTPStatusCode? {
        statusCode
    }
    
    func getTest() -> ResponseTest? {
        test
    }
}
