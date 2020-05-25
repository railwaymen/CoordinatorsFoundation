import Foundation
@testable import CoordinatorsFoundation

class DispatchGroupMock {
    private(set) var enterParams: [EnterParams] = []
    struct EnterParams {}
    
    private(set) var leaveParams: [LeaveParams] = []
    struct LeaveParams {}
    
    private(set) var notifyParams: [NotifyParams] = []
    struct NotifyParams {
        let qos: DispatchQoS
        let flags: DispatchWorkItemFlags
        let queue: DispatchQueue
        let work: () -> Void
    }
}

// MARK: - DispatchGroupType
extension DispatchGroupMock: DispatchGroupType {
    func enter() {
        self.enterParams.append(EnterParams())
    }
    
    func leave() {
        self.leaveParams.append(LeaveParams())
        if self.leaveParams.count == self.enterParams.count {
            self.notifyParams.forEach { $0.work() }
        }
    }
    
    func notify(
        qos: DispatchQoS,
        flags: DispatchWorkItemFlags,
        queue: DispatchQueue,
        execute work: @escaping @convention(block) () -> Void
    ) {
        self.notifyParams.append(NotifyParams(
            qos: qos,
            flags: flags,
            queue: queue,
            work: work))
    }
}
