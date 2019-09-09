//
//  ThirdCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import CoordinatorsFoundation

typealias ThirdCoordinatorChild = NavigationCoordinator & TabBarChildCoordinatorType

protocol ThirdCoordinatorType: class {}

class ThirdCoordinator: NavigationCoordinator {
    private let storyboardsManager: StoryboardsManagerType
    
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
        let vc: ThirdViewControllerable? = self.storyboardsManager.controller(storyboard: .third)
        guard let controller = vc else { return }
        let viewModel = ThirdViewModel()
        controller.configure(viewModel: viewModel)
        self.navigationController = UINavigationController(rootViewController: controller)
    }
}

// MARK: - TabBarChildCoordinatorType
extension ThirdCoordinator: TabBarChildCoordinatorType {
    var root: UIViewController {
        return self.navigationController
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
    }
}

// MARK: - ThirdCoordinatorType
extension ThirdCoordinator: ThirdCoordinatorType {
   
}
