//
//  SecondCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import CoordinatorsFoundation

protocol SecondCoordinatorType: class {
    func viewDidRequestForDetailsView()
    func viewDidFinish()
}

class SecondCoordinator: ControllerCoordinator<DeepLinkOption, CoordinatorType> {
    private let parentController: UINavigationController
    private let storyboardsManager: StoryboardsManagerType
    
    // MARK: - Initialization
    init(
        window: UIWindowType?,
        parentController: UINavigationController,
        storyboardsManager: StoryboardsManagerType
    ) {
        self.parentController = parentController
        self.storyboardsManager = storyboardsManager
        super.init(window: window)
    }
    
    // MARK: - Overridden
    override func start(finishHandler: Coordinator.FinishHandlerType?) {
        super.start(finishHandler: finishHandler)
        self.runMainFlow()
    }
    
    // MARK: - Private
    private func runMainFlow() {
        let vc: SecondViewControllerable? = self.storyboardsManager.controller(storyboard: .second)
        guard let controller = vc else { return }
        let viewModel = SecondViewModel(coordinator: self)
        controller.configure(viewModel: viewModel)
        self.controller = controller
        self.parentController.show(controller, sender: nil)
    }
    
    private func runDetailsFlow() {
        
    }
}

extension SecondCoordinator: SecondCoordinatorType {
    func viewDidRequestForDetailsView() {
        
    }
    
    func viewDidFinish() {
        self.finish()
    }
}
