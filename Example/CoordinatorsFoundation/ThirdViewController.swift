//
//  ThirdViewController.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

typealias ThirdViewControllerable = UIViewController & ThirdViewControllerType

protocol ThirdViewControllerType: class {
    func configure(viewModel: ThirdViewModelType)
}

class ThirdViewController: UIViewController {
    private var viewModel: ThirdViewModelType!
}

// MARK: - ThirdViewControllerType
extension ThirdViewController: ThirdViewControllerType {
    func configure(viewModel: ThirdViewModelType) {
        self.viewModel = viewModel
    }
}
