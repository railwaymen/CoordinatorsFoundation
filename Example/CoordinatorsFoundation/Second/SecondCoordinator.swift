//
//  SecondCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit
import CoordinatorsFoundation

protocol SecondCoordinatorType: class {
    func viewDidRequestToPopToRoot()
    func viewDidFinish()
}

class SecondCoordinator: ControllerCoordinator, Finishable {
    typealias FinishHandlerType = () -> Void
    var willFinishHandler: FinishHandlerType?
    var didFinishHandler: FinishHandlerType?
    
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
    override func start(on parent: Coordinator?) {
        super.start(on: parent)
        self.runMainFlow()
    }
}

// MARK: - SecondCoordinatorType
extension SecondCoordinator: SecondCoordinatorType {
    func viewDidRequestToPopToRoot() {
        self.willFinish()
        self.parentController.popToRootViewController(animated: true)
        self.didFinish()
    }
    
    func viewDidFinish() {
        self.finishInstantly()
    }
}

// MARK: - Private
extension SecondCoordinator {
    private func runMainFlow() {
        let vc: SecondViewControllerable? = self.storyboardsManager.controller(storyboard: .second)
        guard let controller = vc else { return }
        let viewModel = SecondViewModel(coordinator: self)
        controller.configure(viewModel: viewModel)
        self.controller = controller
        self.parentController.show(controller, sender: nil)
    }
}
