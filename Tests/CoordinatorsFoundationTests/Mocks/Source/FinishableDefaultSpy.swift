import XCTest
@testable import CoordinatorsFoundation

class FinishableDefaultSpy: Finishable {
    typealias FinishHandlerType = () -> Void
    
    private(set) var willFinishHandlerParams: [WillFinishHandlerParams] = []
    struct WillFinishHandlerParams {}
    
    private(set) var didFinishHandlerParams: [DidFinishHandlerParams] = []
    struct DidFinishHandlerParams {}
    
    var willFinishHandler: (() -> Void)?
    var didFinishHandler: (() -> Void)?
    
    init() {
        self.willFinishHandler = { [weak self] in
            self?.willFinishHandlerParams.append(WillFinishHandlerParams())
        }
        self.didFinishHandler = { [weak self] in
            self?.didFinishHandlerParams.append(DidFinishHandlerParams())
        }
    }
}
