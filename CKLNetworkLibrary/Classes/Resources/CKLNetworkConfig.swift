//
//  CKLNetwork.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 06/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Attributes

/// server-supplied token string
var tokenAuthApp: String = ""

/// Name to associate with the `Data` in the `Content-Disposition` HTTP header.
var nameMediaType: String = "midia"

/// Show request logs
var isShowLog: Bool = false

/// if requests should only work with WIFI switch to true
var onlyWorkingWithWIFI: Bool = false

// genereic message to show in return, you can change this by setting them after the lib initialization
var genericErrorMessage: String = "Something went wrong, please try again later"
var noInternetErrorMessage: String = "Connection fail"
var authenticationErrorMessage: String = "Authentication fail"


public struct CKLNetworkConfig {
    
    /// Initializatino module.
    /// - Parameters:
    ///   - url: url base to use to list, create and delete methods
    ///   - showLog: show log request
    public init(showLog: Bool) {
        setup(showLog)
    }
    
    private func setup(_ showLog: Bool) {
        isShowLog = showLog
    }
    
    /// Set Token to authentication
    /// - Parameter token: server-supplied token string
    public func setToken(token: String) {
        tokenAuthApp = token
    }
    
    /// Set default description to generic error
    /// - Parameter msg: message
    public func setGenericErrorMessage(msg: String) {
        genericErrorMessage = msg
    }
    
    /// Set default description to no internet error
    /// - Parameter msg: message
    public func setNoInternetErrorMessage(msg: String) {
        noInternetErrorMessage = msg
    }
    
    /// Set default description to authentication error
    /// - Parameter msg: message
    public func setAuthenticationErrorMessage(msg: String) {
        authenticationErrorMessage = msg
    }
    
    /// Set default name
    /// - Parameter name:Name to associate with the `Data` in the `Content-Disposition` HTTP header.
    public func setNameMediaType(name: String) {
        nameMediaType = name
    }
    
    /// It should only work with WIFI
    /// - Parameter wifi: true only WIFI, false for WIFI and mobile connection
    public func setOnlyWorkingWithWIFI(wifi: Bool) {
        onlyWorkingWithWIFI = wifi
    }
}
