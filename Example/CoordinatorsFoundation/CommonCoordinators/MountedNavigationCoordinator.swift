//
//  MountedNavigationCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/01/2020.
//  Copyright © 2020 Railwaymen. All rights reserved.
//

import UIKit
import CoordinatorsFoundation

class MountedNavigationCoordinator: NavigationCoordinator, Finishable {
    typealias FinishHandlerType = () -> Void
    var willFinishHandler: FinishHandlerType?
    var didFinishHandler: FinishHandlerType?
    
    private let storyboardsManager: StoryboardsManagerType
    
    // MARK: - Initialization
    init(
        window: UIWindowType?,
        navigationController: UINavigationController,
        storyboardsManager: StoryboardsManagerType
    ) {
        self.storyboardsManager = storyboardsManager
        super.init(window: window, navigationController: navigationController)
    }
    
    // MARK: - Overridden
    override func start(on parent: Coordinator?) {
        super.start(on: parent)
        self.runMainFlow()
    }
}

// MARK: - PresentedCoordinatorType
extension MountedNavigationCoordinator: PresentedCoordinatorType {
    func showControllerCoordinator() {
        let coordinator = PresentedControllerCoordinator(
            window: self.window,
            parentViewController: self.navigationController,
            storyboardsManager: self.storyboardsManager)
        coordinator.start(on: self)
    }
    
    func requestToFinish() {
        self.willFinish()
        self.navigationController.popViewController(animated: true)
        self.didFinish()
    }
    
    func viewDidFinish() {
        self.finishInstantly()
    }
}

// MARK: - Private
extension MountedNavigationCoordinator {
    private func runMainFlow() {
        let optionalController: FourthViewController? = self.storyboardsManager.controller(storyboard: .fourth)
        guard let viewController = optionalController else { return assertionFailure() }
        let viewModel = FourthViewModel(coordinator: self)
        viewController.configure(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
