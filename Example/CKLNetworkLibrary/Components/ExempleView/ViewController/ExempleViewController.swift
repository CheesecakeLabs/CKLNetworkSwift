//
//  ExempleViewController.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 06/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import UIKit
 

class ExempleViewController: UIViewController {
    
    // MARK: - Attributes
    
    private var viewModel: ExempleViewModel?
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    // MARK: - Outlets
    
    @IBOutlet private weak var labelMessage: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Life cycle
    
    init(viewModel: ExempleViewModel) {
        super.init(nibName: ExempleViewController.className, bundle: Bundle.main)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.fetchExempleData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
    }
    
    // MARK: - Setup Methods
    
    private func bindUI() {
        bindRequest()
        bindReloadData()
        bindError()
    }
    
    func bindError() {
        viewModel?.error.bind { error in
            guard let error = error else { return }
            //TODO: show error
        }
    }
    
    func bindReloadData() {
        viewModel?.reloadInfo.bind { [weak self] responseTest in
            self?.imageView.image =  responseTest?.media?.base64ToImage()
            self?.labelMessage.text = responseTest?.message ?? ""
        }
    }
    
    func bindRequest() {
        viewModel?.isRequesting.bindAndFire { [weak self] isRequesting in
            DispatchQueue.main.async(qos: .userInteractive) { [weak self] in
                isRequesting ?  self?.startAnimation() : self?.stopAnimation()
            }
        }
    }
    
    // MARK: - Others Methods
    
    func startAnimation() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimation() {
        activityIndicator.stopAnimating()
    }
}

