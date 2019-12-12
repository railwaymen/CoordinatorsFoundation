//
//  PresentedControllerCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 10/12/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit
import CoordinatorsFoundation

class PresentedControllerCoordinator: ControllerCoordinator {
    private weak var paretViewController: UIViewController?
    private let storyboardsManager: StoryboardsManagerType
    
    // MARK: - Initialization
    init(
        window: UIWindowType?,
        parentViewController: UIViewController,
        storyboardsManager: StoryboardsManagerType
    ) {
        self.paretViewController = parentViewController
        self.storyboardsManager = storyboardsManager
        super.init(window: window)
    }
    
    // MARK: - Overridden
    override func start(finishHandler: FinishHandlerType?) {
        super.start(finishHandler: finishHandler)
        self.runMainFlow()
    }
}

// MARK: - PresentedCoordinatorType
extension PresentedControllerCoordinator: PresentedCoordinatorType {
    func showControllerCoordinator() {
        self.runControllerCoordinator()
    }
    
    func requestToFinish() {
        self.controller.dismiss(animated: true) { [weak self] in
            self?.finish()
        }
    }
}

// MARK: - Private
extension PresentedControllerCoordinator {
    private func runMainFlow() {
        let optionalController: FourthViewController? = self.storyboardsManager.controller(storyboard: .fourth)
        guard let viewController = optionalController else { return assertionFailure() }
        let viewModel = FourthViewModel(coordinator: self)
        viewController.configure(viewModel: viewModel)
        self.observeDismiss(of: viewController)
        self.controller = viewController
        self.paretViewController?.present(self.controller, animated: true)
    }
    
    private func runControllerCoordinator() {
        let coordinator = PresentedControllerCoordinator(
            window: self.window,
            parentViewController: self.controller,
            storyboardsManager: self.storyboardsManager)
        self.add(child: coordinator)
        coordinator.start { [weak self, weak coordinator] in
            self?.remove(child: coordinator)
        }
    }
}
