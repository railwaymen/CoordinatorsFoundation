//
//  DispatchGroup+Extension.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

protocol DispatchGroupType: class {
    func enter()
    func leave()
    func notify(
        qos: DispatchQoS,
        flags: DispatchWorkItemFlags,
        queue: DispatchQueue,
        execute work: @escaping @convention(block) () -> Void)
}

extension DispatchGroupType {
    func notify(
        qos: DispatchQoS,
        queue: DispatchQueue,
        execute work: @escaping @convention(block) () -> Void
    ) {
        self.notify(qos: qos, flags: [], queue: queue, execute: work)
    }
    
    func notify(
        flags: DispatchWorkItemFlags,
        queue: DispatchQueue,
        execute work: @escaping @convention(block) () -> Void
    ) {
        self.notify(qos: .unspecified, flags: flags, queue: queue, execute: work)
    }
    
    func notify(
        queue: DispatchQueue,
        execute work: @escaping @convention(block) () -> Void
    ) {
        self.notify(qos: .unspecified, flags: [], queue: queue, execute: work)
    }
}

extension DispatchGroup: DispatchGroupType {}
