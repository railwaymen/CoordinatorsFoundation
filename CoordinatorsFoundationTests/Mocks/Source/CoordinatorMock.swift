//
//  CoordinatorMock.swift
//  CoordinatorsFoundationTests
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Bartłomiej Świerad. All rights reserved.
//

import Foundation
@testable import CoordinatorsFoundation

class CoordinatorMock: Coordinator<DeepLinkOptionMock, CoordinatorTypeMock> {
    
    var type_expectedValue: CoordinatorType?
    var type: CoordinatorType? {
        return self.type_expectedValue
    }
    
    var children_expectedValue: [Coordinator] = []
    override var children: [Coordinator] {
        return self.children_expectedValue
    }
    
    var window_expectedValue: UIWindowType?
    override var window: UIWindowType? {
        return self.window_expectedValue
    }
    
    required init(window: UIWindowType?) {
        super.init(window: nil)
    }
    
    private(set) var start_calledCount: Int = 0
    private(set) var start_finishHandler: FinishHandlerType?
    override func start(finishHandler: FinishHandlerType?) {
        self.start_calledCount += 1
        self.start_finishHandler = finishHandler
    }
    
    private(set) var finish_calledCount: Int = 0
    override func finish() {
        self.finish_calledCount += 1
    }
    
    private(set) var addChildCoordinator_calledCount: Int = 0
    private(set) var addChildCoordinator_child: Coordinator?
    override func addChildCoordinator(child: Coordinator) {
        self.addChildCoordinator_calledCount += 1
        self.addChildCoordinator_child = child
    }
    
    private(set) var removeChildCoordinator_calledCount: Int = 0
    private(set) var removeChildCoordinator_child: Coordinator?
    override func removeChildCoordinator(child: Coordinator?) {
        self.removeChildCoordinator_calledCount += 1
        self.removeChildCoordinator_child = child
    }
    
    private(set) var deepLinkWillBeExecuted_calledCount: Int = 0
    private(set) var deepLinkWillBeExecuted_completion: (() -> Void)?
    override func deepLinkWillBeExecuted(completion: @escaping () -> Void) {
        self.deepLinkWillBeExecuted_calledCount += 1
        self.deepLinkWillBeExecuted_completion = completion
    }
    
    private(set) var openDeepLink_calledCount: Int = 0
    private(set) var openDeepLink_option: DeepLinkOption?
    override func openDeepLink(option: DeepLinkOption) {
        self.openDeepLink_calledCount += 1
        self.openDeepLink_option = option
    }
}
