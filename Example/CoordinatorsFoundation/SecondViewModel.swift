//
//  SecondViewModel.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

protocol SecondViewModelType: class {
    func viewDidAppear()
    func viewDidDisappear()
    func viewWillMoveToParent()
    func popButtonTapped()
    func viewDidFinish()
}

class SecondViewModel {
    private weak var coordinator: SecondCoordinatorType?
    private var viewIsAboutToPop: Bool
    
    init(
        coordinator: SecondCoordinatorType?
    ) {
        self.coordinator = coordinator
        
        self.viewIsAboutToPop = false
    }
}

// MARK: - SecondViewModelType
extension SecondViewModel: SecondViewModelType {
    func viewDidAppear() {
        self.viewIsAboutToPop = false
    }
    
    func viewDidDisappear() {
        guard self.viewIsAboutToPop else { return }
        self.coordinator?.viewDidFinish()
    }
    
    func viewWillMoveToParent() {
        self.viewIsAboutToPop = true
    }
    
    func popButtonTapped() {
        self.coordinator?.viewDidRequestToPopToRoot()
    }
    
    func viewDidFinish() {
        self.coordinator?.viewDidFinish()
    }
}
