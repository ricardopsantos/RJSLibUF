//
//  Created by Ricardo Santos on 18/02/2021.
//

import Foundation
import Combine
import SwiftUI

//
// https://medium.com/eggs-design/building-a-state-driven-app-in-swiftui-using-state-machines-32379ca37283
// Building a state-driven app in SwiftUI using state machines
//

public extension RJSLib {
    
    enum HashableModelState<T: Hashable>: Hashable {
        public static func == (lhs: RJSLib.HashableModelState<T>, rhs: RJSLib.HashableModelState<T>) -> Bool {
            switch (lhs, rhs) {
            case (.notLoaded, .notLoaded):
                return true
            case (.loading, .loading):
                return true
            case (.loaded(let t1), .loaded(let t2)):
                return t1 == t2
            case (.error, .error):
                return true
            default:
                return false
            }
        }

        case notLoaded
        case loading
        case loaded(T)
        case error(Error)

        public var selfValue: Int {
            switch self {
            case .notLoaded: return 1
            case .loading: return 2
            case .loaded: return 3
            case .error: return 4
            }
        }

        public var value: T? {
            switch self {
            case .loaded(let t): return t
            default: return nil
            }
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(selfValue)
            switch self {
            case .loaded(let t):
                hasher.combine(t)
            default: ()
            }
        }
    }
}
    
fileprivate extension RJSLib {
    
    func sample() {
        struct SomethingHashable: Hashable {
            public var currencyCode: String
            public func hash(into hasher: inout Hasher) {
                hasher.combine(currencyCode)
            }
        }

        var state: RJS_ViewState<SomethingHashable?> = .notLoaded
        RJS_Logs.info(state)
         
        state = RJS_ViewState.loaded(SomethingHashable(currencyCode: "EUR"))
        RJS_Logs.info(state)

    }
}
