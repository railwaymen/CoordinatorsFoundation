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
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard parent == nil else { return }
        self.viewModel.viewDidFinish()
    }
    
    // MARK: - Actions
    @IBAction private func popButtonTapped(_: Any) {
        self.viewModel.popButtonTapped()
    }
}

// MARK: - SecondViewControllerType
extension SecondViewController: SecondViewControllerType {
    func configure(viewModel: SecondViewModelType) {
        self.viewModel = viewModel
    }
}
