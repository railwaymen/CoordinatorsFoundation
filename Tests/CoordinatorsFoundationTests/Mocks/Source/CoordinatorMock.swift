import Foundation
@testable import CoordinatorsFoundation

class CoordinatorMock: Coordinator<DeepLinkOptionMock, CoordinatorTypeMock> {
    
    private(set) var startParams: [StartParams] = []
    struct StartParams {
        let finishHanlder: FinishHandlerType?
    }
    
    private(set) var finishParams: [FinishParams] = []
    struct FinishParams {}
    
    private(set) var addChildParams: [AddChildParams] = []
    struct AddChildParams {
        let child: Coordinator
    }
    
    private(set) var removeChildParams: [RemoveChildParams] = []
    struct RemoveChildParams {
        let child: Coordinator?
    }
    
    private(set) var deepLinkWillBeExecutedParams: [DeepLinkWillBeExecutedParams] = []
    struct DeepLinkWillBeExecutedParams {
        let completion: () -> Void
    }
    
    private(set) var openDeepLinkParams: [OpenDeepLinkParams] = []
    struct OpenDeepLinkParams {
        let option: DeepLinkOption
    }
    
    var typeReturnValue: CoordinatorType?
    var childrenReturnValue: [Coordinator] = []
    var windowReturnValue: UIWindowType?
    
    // MARK: - Overridden
    override var type: CoordinatorType? {
        return self.typeReturnValue
    }
    
    override var children: [Coordinator] {
        return self.childrenReturnValue
    }
    
    override var window: UIWindowType? {
        return self.windowReturnValue
    }
    
    override func start(finishHandler: FinishHandlerType?) {
        self.startParams.append(StartParams(finishHanlder: finishHandler))
    }
    
    override func finish() {
        self.finishParams.append(FinishParams())
    }
    
    override func add(child: Coordinator) {
        self.addChildParams.append(AddChildParams(child: child))
    }
    
    override func remove(child: Coordinator?) {
        self.removeChildParams.append(RemoveChildParams(child: child))
    }

    override func deepLinkWillBeExecuted(completion: @escaping () -> Void) {
        self.deepLinkWillBeExecutedParams.append(DeepLinkWillBeExecutedParams(completion: completion))
    }
    
    override func openDeepLink(option: DeepLinkOption) {
        self.openDeepLinkParams.append(OpenDeepLinkParams(option: option))
    }
}
