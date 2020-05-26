//
//  AppDelegate.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/05/2019.
//  Copyright (c) 2019 Railwaymen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let window = UIWindow()
        self.appCoordinator = AppCoordinator(
            window: window,
            storyboardsManager: StoryboardsManager())
        self.appCoordinator?.start(on: nil)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}
