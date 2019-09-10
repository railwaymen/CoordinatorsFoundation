//
//  SecondViewModel.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

protocol SecondViewModelType: class {
    func popButtonTapped()
    func viewDidFinish()
}

class SecondViewModel {
    private weak var coordinator: SecondCoordinatorType?
    
    init(
        coordinator: SecondCoordinatorType?
    ) {
        self.coordinator = coordinator
    }
}

// MARK: - SecondViewModelType
extension SecondViewModel: SecondViewModelType {
    func popButtonTapped() {
        self.coordinator?.viewDidRequestToPopToRoot()
    }
    
    func viewDidFinish() {
        self.coordinator?.viewDidFinish()
    }
}
