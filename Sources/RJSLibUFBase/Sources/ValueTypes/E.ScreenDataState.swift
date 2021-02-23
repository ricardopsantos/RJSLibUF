//
//  Created by Ricardo Santos on 18/02/2021.
//

import Foundation

public extension RJSLib {
    
    enum ScreenDataState<T: Hashable>: Hashable {
        public static func == (lhs: ScreenDataState<T>, rhs: ScreenDataState<T>) -> Bool {
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
            case .loaded(let t):
                return t
            default:
                return nil
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

private extension RJSLib {
    func sampleScreenDataState() {
        struct Something: Hashable {
            public var currencyCode: String
            public func hash(into hasher: inout Hasher) {
                hasher.combine(currencyCode)
            }
        }
        var state: ScreenDataState<Something?> = .notLoaded
    }
}
