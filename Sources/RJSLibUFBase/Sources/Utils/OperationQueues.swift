//
//  Created by Ricardo Santos on 30/01/2021.
//

import Foundation

public extension RJSLib {
    struct OperationQueues {
        private init() { }
    }
}

/**

 __USAGE__
 
 Given:
 
 ```
 private class DownloadImageOperation: RJSLibOperationBase {
     let urlString: String
     var image: UIImage!
     init(withURLString urlString: String) {
         self.urlString = urlString
     }
     public override func main() {
         guard isCancelled == false else {
             finish(true)
             return
         }
         executing(true)
         networkingUtilsDownloadImage(imageURL: urlString, onFail: Images.notFound.image) { (image) in
             self.image = image!
             self.executing(false)
             self.finish(true)
         }
     }
 }
 ```
 
 Do:
 
 ```
 let operation = DownloadImageOperation(withURLString: size.source)
 RJS_OperationQueueManager.shared.add(operation)
 operation.completionBlock = {
     if operation.isCancelled {
         observer.on(.next(Images.notFound.image))
     } else {
         observer.on(.next(operation.image))
     }
     observer.on(.completed)
 }
 ```
 
 */

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
