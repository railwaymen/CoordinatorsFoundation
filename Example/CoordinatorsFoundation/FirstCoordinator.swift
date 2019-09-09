//
//  FirstCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import CoordinatorsFoundation

typealias FirstCoordinatorable = NavigationCoordinator<DeepLinkOption, CoordinatorType>
    & TabBarChildCoordinatorType

protocol FirstCoordinatorType: class {
    func viewDidRequestForSecondView()
}

class FirstCoordinator: FirstCoordinatorable {
    private let storyboardsManager: StoryboardsManagerType
    
    // MARK: - TabBarChildCoordinatorType
    var root: UIViewController {
        return self.navigationController
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
    }
    
    // MARK: - Initialization
    init(
        window: UIWindowType?,
        storyboardsManager: StoryboardsManagerType
    ) {
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
        let vc: FirstViewControllerable? = self.storyboardsManager.controller(storyboard: .first)
        guard let controller = vc else { return }
        let viewModel = FirstViewModel(coordinator: self)
        controller.configure(viewModel: viewModel)
        self.navigationController = UINavigationController(rootViewController: controller)
        self.window?.rootViewController = self.navigationController
    }
    
    private func runSecondFlow() {
        let coordinator = SecondCoordinator(
            window: nil,
            parentController: self.navigationController,
            storyboardsManager: self.storyboardsManager)
        self.addChildCoordinator(child: coordinator)
        coordinator.start { [weak self, weak coordinator] in
            self?.removeChildCoordinator(child: coordinator)
        }
    }
}

// MARK: - FirstCoordinatorType
extension FirstCoordinator: FirstCoordinatorType {
    func viewDidRequestForSecondView() {
        self.runSecondFlow()
    }
}
