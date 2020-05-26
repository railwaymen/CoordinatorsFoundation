//
//  FourthViewModel.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 10/12/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

protocol FourthViewModelType: class {
    func presentButtonTapped()
    func dismissButtonTapped()
    func viewDidFinish()
}

class FourthViewModel {
    private weak var coordinator: PresentedCoordinatorType?
    
    // MARK: - Initialization
    init(coordinator: PresentedCoordinatorType?) {
        self.coordinator = coordinator
    }
}

// MARK: - FourthViewModelType
extension FourthViewModel: FourthViewModelType {
    func presentButtonTapped() {
        self.coordinator?.showControllerCoordinator()
    }
    
    func dismissButtonTapped() {
        self.coordinator?.requestToFinish()
    }
    
    func viewDidFinish() {
        self.coordinator?.viewDidFinish()
    }
}
