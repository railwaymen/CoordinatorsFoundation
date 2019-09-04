//
//  UIWindow+Extension.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Bartłomiej Świerad. All rights reserved.
//

import UIKit

protocol UIWindowType: class {
    var rootViewController: UIViewController? { get set }
}

extension UIWindow: UIWindowType {}
