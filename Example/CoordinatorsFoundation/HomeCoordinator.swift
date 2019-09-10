//
//  HomeCoordinator.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import CoordinatorsFoundation

class HomeCoordinator: TabBarCoordinator {
    var type: CoordinatorType? {
        return .home
    }
    
    init(
        window: UIWindowType?,
        storyboardsManager: StoryboardsManagerType
    ) {
        let firstChild = FirstCoordinator(
            window: nil,
            storyboardsManager: storyboardsManager)
        let secondChild = ThirdCoordinator(
            window: nil,
            storyboardsManager: storyboardsManager)
        
        super.init(window: window)
        let children = [firstChild, secondChild]
        children.forEach { self.addChildCoordinator(child: $0) }
        children.forEach { $0.start() }
    }
}
