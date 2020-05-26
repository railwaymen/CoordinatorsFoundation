//
//  FirstViewModel.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

protocol FirstViewModelType: class {
    func nextButtonTapped()
}

class FirstViewModel {
    private weak var coordinator: FirstCoordinatorType?
    
    // MARK: - Initialization
    init(coordinator: FirstCoordinatorType?) {
        self.coordinator = coordinator
    }
}

// MARK: - FirstViewModelType
extension FirstViewModel: FirstViewModelType {
    func nextButtonTapped() {
        self.coordinator?.viewDidRequestForSecondView()
    }
}
