//
//  AppCoordinator.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 08/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    func start(_ completion: (() -> Void)?)
}

extension Coordinator {
    
    func start(_ completion: (() -> Void)? = nil) {
        start(completion)
    }
}

final class AppCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    static var window: UIWindow? = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.window
    }()
    
    // MARK: - Navigations
    
    static func start() {
        let navigation = UINavigationController()
        let exemple = ExempleCoordinator(presenter: navigation)
        exemple.start()
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
    }
    
    static func visibleViewController() -> UIViewController? {
        guard let rootViewController: UIViewController = self.window?.rootViewController  else { return nil }
        return self.getVisibleViewControllerFrom(rootViewController)
    }
    
    // swiftlint:disable cognitive_complexity
    private static func getVisibleViewControllerFrom(_ viewController: UIViewController?) -> UIViewController? {
        
        if let navigationController = viewController?.isKindType(of: UINavigationController.self) {
            return getVisibleViewControllerFrom(navigationController.visibleViewController)
        } else if let tabBarController = viewController?.isKindType(of: UITabBarController.self) {
            return getVisibleViewControllerFrom(tabBarController.selectedViewController)
        }
        
        guard let currentVC = viewController?.presentedViewController else { return viewController }
        return getVisibleViewControllerFrom(currentVC)
    }
}
