//
//  StoryboardsManager.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

protocol StoryboardsManagerType: class {
    func controller<T>(
        storyboard: StoryboardsManager.StoryboardName,
        controllerIdentifier: StoryboardsManager.ControllerIdentifier) -> T?
}

extension StoryboardsManagerType {
    func controller<T>(storyboard: StoryboardsManager.StoryboardName) -> T? {
        return self.controller(
            storyboard: storyboard,
            controllerIdentifier: .initial)
    }
}

class StoryboardsManager: StoryboardsManagerType {
    
    static var shared: StoryboardsManagerType = StoryboardsManager()
    
    enum StoryboardName: String {
        case first = "First"
        case second = "Second"
    }
    
    enum ControllerIdentifier: String {
        case initial
    }
    
    // MARK: - Internal
    func controller<T>(
        storyboard: StoryboardsManager.StoryboardName,
        controllerIdentifier: StoryboardsManager.ControllerIdentifier
    ) -> T? {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        switch controllerIdentifier {
        case .initial:
            return storyboard.instantiateInitialViewController() as? T
        default:
            return storyboard.instantiateViewController(
                withIdentifier: controllerIdentifier.rawValue) as? T
        }
    }
}
