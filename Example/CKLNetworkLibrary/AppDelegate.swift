//
//  AppDelegate.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 06/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import UIKit
import CKLNetworkLibrary

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        var config: Config = Config()
        
        let ckl = CKLNetworkConfig.init(url:  config.baseURL, showLog: true)
        
        //set token authentication
        ckl.setToken(token: "token provide in login")
        
        /* other changes you can make
        ckl.setAuthenticationErrorMessage(msg: <#T##String#>)
        ckl.setNoInternetErrorMessage(msg: <#T##String#>)
        ckl.setGenericErrorMessage(msg: <#T##String#>)
        ckl.setOnlyWorkingWithWIFI(wifi: <#T##Bool#>)
        */
        
        AppCoordinator.start()
        
        return true
    }
}
