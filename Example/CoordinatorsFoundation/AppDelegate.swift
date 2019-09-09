//
//  AppDelegate.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/05/2019.
//  Copyright (c) 2019 Railwaymen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let window = UIWindow()
        let appCoordinator = AppCoordinator(
            window: window,
            storyboardsManager: StoryboardsManager())
        appCoordinator.start()
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}
