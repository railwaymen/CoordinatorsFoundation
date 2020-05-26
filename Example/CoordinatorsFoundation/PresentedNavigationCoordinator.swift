//
//  PresentedNavigationCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 10/12/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit
import CoordinatorsFoundation

protocol PresentedCoordinatorType: class {
    func showControllerCoordinator()
    func requestToFinish()
    func viewDidFinish()
}

class PresentedNavigationCoordinator: NavigationCoordinator, Finishable {
    typealias FinishHandlerType = () -> Void
    var willFinishHandler: FinishHandlerType?
    var didFinishHandler: FinishHandlerType?
    
    private weak var parentViewController: UIViewController?
    private let storyboardsManager: StoryboardsManagerType
    
    // MARK: - Initialization
    init(
        window: UIWindowType?,
        parentViewController: UIViewController,
        storyboardsManager: StoryboardsManagerType
    ) {
        self.parentViewController = parentViewController
        self.storyboardsManager = storyboardsManager
        super.init(window: window)
    }
    
    // MARK: - Overridden
    override func start(on parent: Coordinator?) {
        super.start(on: parent)
        self.runMainFlow()
    }
    
    override func willFinish() {
        super.willFinish()
        self.willFinishHandler?()
    }
    
    override func didFinish() {
        super.didFinish()
        self.didFinishHandler?()
    }
}

// MARK: - PresentedCoordinatorType
extension PresentedNavigationCoordinator: PresentedCoordinatorType {
    func showControllerCoordinator() {
        self.runControllerCoordinator()
    }

    func requestToFinish() {
        self.willFinish()
        self.navigationController.dismiss(animated: true) { [weak self] in
            self?.didFinish()
        }
    }
    
    func viewDidFinish() {
        self.finishInstantly()
    }
}

// MARK: - Private
extension PresentedNavigationCoordinator {
    private func runMainFlow() {
        let optionalController: FourthViewController? = self.storyboardsManager.controller(storyboard: .fourth)
        guard let viewController = optionalController else { return assertionFailure() }
        let viewModel = FourthViewModel(coordinator: self)
        viewController.configure(viewModel: viewModel)
        self.navigationController.setViewControllers([viewController], animated: false)
        self.parentViewController?.present(self.navigationController, animated: true)
    }
    
    private func runControllerCoordinator() {
        let coordinator = MountedNavigationCoordinator(
            window: self.window,
            navigationController: self.navigationController,
            storyboardsManager: self.storyboardsManager)
        coordinator.start(on: self)
    }
}
