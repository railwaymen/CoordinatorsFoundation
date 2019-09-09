//
//  FirstViewController.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

typealias FirstViewControllerable = UIViewController & FirstViewControllerType

protocol FirstViewControllerType: class {
    func configure(viewModel: FirstViewModelType)
}

class FirstViewController: UIViewController {
    private var viewModel: FirstViewModelType!
    
    // MARK: - Actions
    @IBAction private func nextButtonTapped(_: Any) {
        self.viewModel.nextButtonTapped()
    }
}

// MARK: - FirstViewControllerType
extension FirstViewController: FirstViewControllerType {
    func configure(viewModel: FirstViewModelType) {
        self.viewModel = viewModel
    }
}
