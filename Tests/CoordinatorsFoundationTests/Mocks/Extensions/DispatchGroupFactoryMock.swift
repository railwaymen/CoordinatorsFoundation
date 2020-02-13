import Foundation
@testable import CoordinatorsFoundation

class DispatchGroupFactoryMock {
    
    var createDispatchGroupReturnValue: DispatchGroupType = DispatchGroupMock()
    private(set) var createDispatchGroupParams: [CreateDispatchGroupParams] = []
    struct CreateDispatchGroupParams {}
}

// MARK: - DispatchGroupFactoryType
extension DispatchGroupFactoryMock: DispatchGroupFactoryType {
    func createDispatchGroup() -> DispatchGroupType {
        self.createDispatchGroupParams.append(CreateDispatchGroupParams())
        return self.createDispatchGroupReturnValue
    }
}
