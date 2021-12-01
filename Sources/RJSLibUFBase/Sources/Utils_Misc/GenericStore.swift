//
//  Created by Ricardo Santos on 15/03/2021.
//

import SwiftUI
import Combine

public extension RJSLib {
    final class GenericStore<Value, Action>: ObservableObject {
        //typealias ReducerType = (inout Value, Action) -> Void
        
        // Reducer that takes a value and action and return a new value
        let reducer: (inout Value, Action) -> Void
        @Published public var value: Value
        public init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
            self.value = initialValue
            self.reducer = reducer
        }
        
        public func send(_ action: Action, debug: Bool = false) {
            if debug {
                RJS_Logs.debug("Sent action [\(action)]", tag: .rjsLib)
            }
            self.reducer(&self.value, action)
        }
    }
}
