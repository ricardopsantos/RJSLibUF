//
//  Created by Ricardo Santos on 19/08/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

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
