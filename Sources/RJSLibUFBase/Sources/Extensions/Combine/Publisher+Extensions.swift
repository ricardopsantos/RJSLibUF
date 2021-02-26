//
//  Created by Ricardo Santos on 19/08/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

/**
 # Publishers and Subscribers
 - A Publisher _publishes_ values ...
 - A Subscriber _subscribes_ to receive publisher's values
 
 __Specifics__:
 - Publishers are _typed_ to the data and error types they can emit
 - A publisher can emit, zero, one or more values and terminate gracefully or with an error of the type it declared.

************
 
 # Subjects
 - A subject is a publisher ...
 - ... relays values it receives from other publishers ...
 - ... can be manually fed with new values
 - ... subjects as also subscribers, and can be used with `subscribe(_:)`

 ************
 
 # Subscription details
 - A subscriber will receive a _single_ subscription
 - _Zero_ or _more_ values can be published
 - At most _one_ {completion, error} will be called
 - After completion, nothing more is received
 
 # Cancellation
 A subscription returns a `Cancellable` object

 Correct memory management using `Cancellable` makes sure you're not retaining any references.
 
 ************
 
 # Simple operators
 - Operators are functions defined on publisher instances...
 - ... each operator returns a new publisher ...
 - ... operators can be chained to add processing steps
 
 */

public extension Publisher {
        
    func sampleOperator<T>(source: T) -> AnyPublisher<Self.Output, Self.Failure> where T: Publisher, T.Output: Equatable, T.Failure == Self.Failure {
        combineLatest(source)
            .removeDuplicates(by: { (first, second) -> Bool in first.1 == second.1 })
            .map { first in first.0 }
        .eraseToAnyPublisher()
    }
}

public extension Publisher {
    
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error): result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }

    /// Holds the downstream delivery of output until the specified time interval passed after the subscription
    /// Does not hold the output if it arrives later than the time threshold
    ///
    /// - Parameters:
    ///   - interval: The minimum time interval that should elapse after the subscription.
    /// - Returns: A publisher that optionally delays delivery of elements to the downstream receiver.

    func delay(seconds: TimeInterval) -> AnyPublisher<Output, Failure> {
        delay(milliseconds: seconds * 1000)
    }
    
    func delay(milliseconds: TimeInterval) -> AnyPublisher<Output, Failure> {
        let timer = Just<Void>(())
            .delay(for: .seconds(milliseconds), scheduler: RunLoop.main)
            .setFailureType(to: Failure.self)
        return zip(timer)
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
}
