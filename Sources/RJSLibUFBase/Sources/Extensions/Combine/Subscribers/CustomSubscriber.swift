//
//  Created by Ricardo Santos on 28/02/2021.
//

import Foundation
import Combine

//
// https://betterprogramming.pub/how-to-create-your-own-combine-subscriber-in-swift-5-702b3f9c68c4
// How to Create Your Own Combine Subscriber in Swift 5
//

// We have to implement three required methods:
// 1 - One that specifies the number of values our subscriber can receive
// 2 - One that handles the received input and expands the number of values the subscriber can receive
// 3 - One that handles the completion event

extension RJSLib {
    class GenericSubscriber<T>: Subscriber {
        typealias Input = T
        typealias Failure = Never
        
        func receive(subscription: Subscription) {
            subscription.request(.unlimited)
        }
        
        func receive(_ input: T) -> Subscribers.Demand {
            RJS_Logs.info("Received: \(input), \( T.self)", tag: .rjsLib)
            return .none
        }
        
        func receive(completion: Subscribers.Completion<Never>) {
            RJS_Logs.info("Completion event: \(completion)", tag: .rjsLib)
        }
    }
}

extension RJSLib {
    class CustomSubscriber: Subscriber {
        typealias Input = String  // Mandatory for Subscriber protocol
        typealias Failure = Never // Mandatory for Subscriber protocol
            
        // First, let’s specify the the maximum number of future values:
        // We have no limitation for the count of Strings we’d receive, so we specify an .unlimited enum case.
        func receive(subscription: Subscription) {
            subscription.request(.unlimited)
        }
        
        // Because we’ve already specified the .unlimited number of values, we return .none so the max limit remains the same.
        func receive(_ input: String) -> Subscribers.Demand {
            RJS_Logs.info("Received: \(input) Transformed into: \(input.uppercased())", tag: .rjsLib)
            return .none
        }
        
        func receive(completion: Subscribers.Completion<Never>) {
            RJS_Logs.info("Completion event: \(completion)", tag: .rjsLib)
        }
    }
}

fileprivate extension RJSLib {
    func sample1() {
        let customPublisher = [
            "Warsaw", "Barcelona", "New York", "Toronto"
        ].publisher

        let customSubscriber = CustomSubscriber()

        customPublisher.subscribe(customSubscriber)
        
        customPublisher
    }
    
    func sample2() {
        let publisherOfInts = [
            1, 2, 3, 4
        ].publisher

        let publisherOfStrings = [
            "1", "2", "3", "4"
        ].publisher

        let subscriberOfInt = GenericSubscriber<Int>()
        let subscriberOfString = GenericSubscriber<String>()

        publisherOfInts.subscribe(subscriberOfInt)
        publisherOfStrings.subscribe(subscriberOfString)
    }
}
