//
//  SecondViewController.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

typealias SecondViewControllerable = UIViewController & SecondViewControllerType

protocol SecondViewControllerType: class {
    func configure(viewModel: SecondViewModelType)
}

class SecondViewController: UIViewController {
    private var viewModel: SecondViewModelType!

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.viewDidDisappear()
    }
    
    // MARK: - Actions
    @IBAction private func nextButtonTapped(_: Any) {
        self.viewModel.nextButtonTapped()
    }
    
    @IBAction private func detailsButtonTapped(_: Any) {
        self.viewModel.detailsButtonTapped()
    }
}

// MARK: - SecondViewControllerType
extension SecondViewController: SecondViewControllerType {
    func configure(viewModel: SecondViewModelType) {
        self.viewModel = viewModel
    }
}
