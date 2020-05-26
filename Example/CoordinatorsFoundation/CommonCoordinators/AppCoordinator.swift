//
//  AppCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation
import CoordinatorsFoundation

class AppCoordinator: Coordinator {
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

// MARK: - Private
extension AppCoordinator {
    private func runMainFlow() {
        let coordinator = HomeCoordinator(
            window: self.window,
            storyboardsManager: self.storyboardsManager)
        coordinator.start(on: self)
    }
}
