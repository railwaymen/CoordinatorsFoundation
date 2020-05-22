//
//  ThirdViewModel.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

protocol ThirdViewModelType: class {
    func presentButtonTapped()
}

class ThirdViewModel {
    private weak var coordinator: ThirdCoordinatorType?
    
    // MARK: - Initialization
    init(coordinator: ThirdCoordinatorType?) {
        self.coordinator = coordinator
    }
}

// MARK: - ThirdViewModelType
extension ThirdViewModel: ThirdViewModelType {
    func presentButtonTapped() {
        self.coordinator?.presentNavigationCoordinator()
    }
}
