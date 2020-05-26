//
//  ControllerHandler.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 10/12/2019.
//

import UIKit

struct ControllerHandler {
    let controller: UIViewController
    let willDismissHandler: (() -> Void)
    let didDismissHandler: (() -> Void)
}

// MARK: - Hashable
extension ControllerHandler: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.controller)
    }
}

// MARK: - Equatable
extension ControllerHandler: Equatable {
    static func == (lhs: ControllerHandler, rhs: ControllerHandler) -> Bool {
        return lhs.controller === rhs.controller
    }
}
