//
//  FourthViewController.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 10/12/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit
import CoordinatorsFoundation

protocol FourthViewControllerType: class {
    func configure(viewModel: FourthViewModelType)
}

class FourthViewController: UIViewController {
    private var viewModel: FourthViewModelType!
    
    // MARK: - Actions
    @IBAction private func presentButtonTapped() {
        self.viewModel.presentButtonTapped()
    }
    
    @IBAction private func dismissButtonTapped() {
        self.viewModel.dismissButtonTapped()
    }
}

// MARK: - FourthViewControllerType
extension FourthViewController: FourthViewControllerType {
    func configure(viewModel: FourthViewModelType) {
        self.viewModel = viewModel
    }
}
