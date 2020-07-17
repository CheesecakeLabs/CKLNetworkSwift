//
//  ExempleCoordinator.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 08/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation
import UIKit

final class ExempleCoordinator: Coordinator {

    // MARK: - Attributes
    
    private weak var navigation: UINavigationController?
    
    // MARK: - Life Cycle
    
    init(presenter: UINavigationController) {
        navigation = presenter
    }
    
    // MARK: - Navigation
    
    func start() {
        let viewModel = ExempleViewModel(coordinator: self)
        let viewController = ExempleViewController(viewModel: viewModel)
        navigation?.pushViewController(viewController, animated: true)
    }
}
