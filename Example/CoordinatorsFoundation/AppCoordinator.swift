//
//  AppCoordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation
import CoordinatorsFoundation

enum DeepLinkOption: DeepLinkOptionable {
    case mainScreen
}

enum CoordinatorType: String, CoordinatorTypable {
    case login
}

class AppCoordinator: Coordinator<DeepLinkOption, CoordinatorType> {
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
        self.runFirstFlow()
    }
    
    // MAKR: - Private
    private func runFirstFlow() {
        let coordinator = FirstCoordinator(
            window: self.window,
            storyboardsManager: self.storyboardsManager)
        self.addChildCoordinator(child: coordinator)
        coordinator.start { [weak self, weak coordinator] in
            self?.removeChildCoordinator(child: coordinator)
        }
    }
}
