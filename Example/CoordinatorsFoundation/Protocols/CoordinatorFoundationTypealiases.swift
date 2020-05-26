//
//  CoordinatorFoundationTypealiases.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import CoordinatorsFoundation

typealias Coordinator = CoordinatorsFoundation.Coordinator<DeepLinkOption, CoordinatorType>
typealias ControllerCoordinator = CoordinatorsFoundation.ControllerCoordinator<DeepLinkOption, CoordinatorType>
typealias NavigationCoordinator = CoordinatorsFoundation.NavigationCoordinator<DeepLinkOption, CoordinatorType>
typealias TabBarCoordinator = CoordinatorsFoundation.TabBarCoordinator<DeepLinkOption, CoordinatorType>
