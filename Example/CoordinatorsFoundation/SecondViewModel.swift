//
//  SecondViewModel.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

protocol SecondViewModelType: class {
    func viewDidDisappear()
    func nextButtonTapped()
    func detailsButtonTapped()
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
    func viewDidDisappear() {
        self.coordinator?.viewDidFinish()
    }
    
    func nextButtonTapped() {
        
    }
    
    func detailsButtonTapped() {
        self.coordinator?.viewDidRequestForDetailsView()
    }
}
