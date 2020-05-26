import XCTest
@testable import CoordinatorsFoundation

class FinishableCoordinatorSpy: Coordinator<DeepLinkOptionMock, CoordinatorTypeMock>, Finishable {
    typealias FinishHandlerType = () -> Void
    
    private(set) var willFinishHandlerParams: [WillFinishHandlerParams] = []
    struct WillFinishHandlerParams {}
    
    private(set) var didFinishHandlerParams: [DidFinishHandlerParams] = []
    struct DidFinishHandlerParams {}
    
    private(set) var handleFinishParams: [HandleFinishParams] = []
    struct HandleFinishParams {}
    
    var willFinishHandler: (() -> Void)?
    var didFinishHandler: (() -> Void)?
    
    init() {
        super.init()
        self.willFinishHandler = { [weak self] in
            self?.willFinishHandlerParams.append(WillFinishHandlerParams())
        }
        self.didFinishHandler = { [weak self] in
            self?.didFinishHandlerParams.append(DidFinishHandlerParams())
        }
    }
    
    override func handleFinish() {
        self.handleFinishParams.append(HandleFinishParams())
    }
}
