//
//  FirstCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit
import CoordinatorsFoundation

protocol FirstCoordinatorType: class {
    func viewDidRequestForSecondView()
}

class FirstCoordinator: NavigationCoordinator, Finishable {
    typealias FinishHandlerType = () -> Void
    var willFinishHandler: FinishHandlerType?
    var didFinishHandler: FinishHandlerType?
    
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
    override func start(on parent: Coordinator?) {
        super.start(on: parent)
        self.runMainFlow()
    }
}

// MARK: - TabBarChildCoordinatorType
extension FirstCoordinator: TabBarChildCoordinatorType {
    var root: UIViewController {
        return self.navigationController
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
    }
}

// MARK: - FirstCoordinatorType
extension FirstCoordinator: FirstCoordinatorType {
    func viewDidRequestForSecondView() {
        self.runSecondFlow()
    }
}

// MARK: - Private
extension FirstCoordinator {
    private func runMainFlow() {
        let vc: FirstViewControllerable? = self.storyboardsManager.controller(storyboard: .first)
        guard let controller = vc else { return }
        let viewModel = FirstViewModel(coordinator: self)
        controller.configure(viewModel: viewModel)
        self.navigationController = UINavigationController(rootViewController: controller)
    }
    
    private func runSecondFlow() {
        let coordinator = SecondCoordinator(
            window: self.window,
            parentController: self.navigationController,
            storyboardsManager: self.storyboardsManager)
        coordinator.start(on: self)
    }
}
