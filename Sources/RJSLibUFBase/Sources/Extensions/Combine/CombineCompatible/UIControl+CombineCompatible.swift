//
//  Created by Ricardo Santos on 19/02/2021.
//
#if !os(macOS)
import Foundation
import Combine
import UIKit

//
// Based on https://www.avanderlee.com/swift/custom-combine-publisher/
//

public extension RJSCombineCompatibleProtocol where Self: UIControl {
    
    func publisher(for events: UIControl.Event) -> RJSLib.UIControlPublisher<UIControl> {
        rjsPublisher(for: events)
    }
    
    func rjsPublisher(for events: UIControl.Event) -> RJSLib.UIControlPublisher<UIControl> {
        return RJSLib.UIControlPublisher(control: self, events: events)
    }
}



extension RJSLib {
    
    /// A custom `Publisher` to work with our custom `UIControlSubscription`.
    public struct UIControlPublisher<Control: UIControl>: Publisher {

        public typealias Output = Control
        public typealias Failure = Never

        let control: Control
        let controlEvents: UIControl.Event

        init(control: Control, events: UIControl.Event) {
            self.control = control
            self.controlEvents = events
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
            let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
            subscriber.receive(subscription: subscription)
        }
    }
    
    public final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
        private var subscriber: SubscriberType?
        private let control: Control

        public init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
            self.subscriber = subscriber
            self.control = control
            control.addTarget(self, action: #selector(eventHandler), for: event)
        }

        public func request(_ demand: Subscribers.Demand) {
            // We do nothing here as we only want to send events when they occur.
            // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
        }

        public func cancel() {
            subscriber = nil
        }

        @objc private func eventHandler() {
            _ = subscriber?.receive(control)
        }
    }

}
#endif
