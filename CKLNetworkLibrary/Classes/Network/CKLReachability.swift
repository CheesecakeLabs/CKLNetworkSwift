//
//  CKLReachability.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 06/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation
import SystemConfiguration

class CKLReachability {
    
    /// checks the internet connection
    /// - Returns: status of connection
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        guard
            let defaultRoute = defaultRouteReachability,
            SCNetworkReachabilityGetFlags(defaultRoute, &flags) == true
            else { return false }
        
        // Working only with WIFI
        if onlyWorkingWithWIFI {
            let isReachable = flags == .reachable
            let needsConnection = flags == .connectionRequired
            
            return isReachable && !needsConnection
        }
        
        // Working for Mobile Connection and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
}

