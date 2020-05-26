import Foundation
@testable import CoordinatorsFoundation

class CoordinatorMock: Coordinator<DeepLinkOptionMock, CoordinatorTypeMock> {
    
    private(set) var startParams: [StartParams] = []
    struct StartParams {}
    
    private(set) var handleFinishParams: [HandleFinishParams] = []
    struct HandleFinishParams {}
    
    private(set) var addChildParams: [AddChildParams] = []
    struct AddChildParams {
        let child: SomeCoordinator
    }
    
    private(set) var removeChildParams: [RemoveChildParams] = []
    struct RemoveChildParams {
        let child: SomeCoordinator?
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
    var childrenReturnValue: [SomeCoordinator] = []
    var windowReturnValue: UIWindowType?
    
    // MARK: - Overridden
    override var type: CoordinatorType? {
        return self.typeReturnValue
    }
    
    override var children: [SomeCoordinator] {
        return self.childrenReturnValue
    }
    
    override var window: UIWindowType? {
        return self.windowReturnValue
    }
    
    override func start(on parent: SomeCoordinator?) {
        self.startParams.append(StartParams())
    }
    
    override func handleFinish() {
        self.handleFinishParams.append(HandleFinishParams())
    }
    
    override func add(child: SomeCoordinator) {
        self.addChildParams.append(AddChildParams(child: child))
    }
    
    override func remove(child: SomeCoordinator?) {
        self.removeChildParams.append(RemoveChildParams(child: child))
    }

    override func deepLinkWillBeExecuted(completion: @escaping () -> Void) {
        self.deepLinkWillBeExecutedParams.append(DeepLinkWillBeExecutedParams(completion: completion))
    }
    
    override func openDeepLink(option: DeepLinkOption) {
        self.openDeepLinkParams.append(OpenDeepLinkParams(option: option))
    }
}
