//
//  UIWindow+Extension.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

public protocol UIWindowType: class {
    var rootViewController: UIViewController? { get set }
}

extension UIWindow: UIWindowType {}
