//
//  HomeCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import CoordinatorsFoundation

class HomeCoordinator: TabBarCoordinator {
    override var type: CoordinatorType? {
        return .home
    }
    
    // MARK: - Initialization
    init(
        window: UIWindowType?,
        storyboardsManager: StoryboardsManagerType
    ) {
        let firstChild = FirstCoordinator(
            window: window,
            storyboardsManager: storyboardsManager)
        let secondChild = ThirdCoordinator(
            window: window,
            storyboardsManager: storyboardsManager)
        
        super.init(window: window)
        window?.rootViewController = self.tabBarController
        let children = [firstChild, secondChild]
        children.forEach { self.add(child: $0) }
        children.forEach { $0.start() }
    }
}
