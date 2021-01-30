//
//  Created by Ricardo Santos on 30/01/2021.
//

import Foundation

public extension RJSLib {
    struct OperationQueues {
        private init() { }
    }
}

public extension RJSLib.OperationQueues {
    class OperationQueueManager {
        private init() {
            if operationQueue == nil {
                operationQueue = OperationQueue()
                operationQueue!.maxConcurrentOperationCount = 5
            }
        }
        private var operationQueue: OperationQueue?
        public static var shared = OperationQueueManager()

        public func add(_ operation: Operation) {
            guard let operationQueue = operationQueue else {
                return
            }
            if operationQueue.operations.count > 10 {
                RJS_Logs.warning("Too many operations: \(operationQueue.operations.count)")
            }
            operationQueue.addOperations([operation], waitUntilFinished: false)
        }
    }
}

// Must be open in order to be heritaded
open class RJSLibOperationBase: Operation {
    private var _executing = false {
        willSet { willChangeValue(forKey: "isExecuting") }
        didSet { didChangeValue(forKey: "isExecuting") }
    }
    public override var isExecuting: Bool { return _executing }
    private var _finished = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet { didChangeValue(forKey: "isFinished") }
    }
    public override var isFinished: Bool { return _finished }
    public func executing(_ executing: Bool) { _executing = executing }
    public func finish(_ finished: Bool) { _finished = finished }
}
