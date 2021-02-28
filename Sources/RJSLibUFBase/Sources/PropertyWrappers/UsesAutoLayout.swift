//
//  Created by Ricardo Santos on 20/02/2021.
//
#if !os(macOS)
import Foundation
import UIKit

/**
 ```
 final class MyViewController {
     @RJSLib.UsesAutoLayout
     var label = UILabel()
 }
 ```
 */

public extension RJSLib {
    @propertyWrapper
    struct UsesAutoLayout<T: UIView> {
        public var wrappedValue: T {
            didSet {
                wrappedValue.translatesAutoresizingMaskIntoConstraints = false
            }
        }

        public init(wrappedValue: T) {
            self.wrappedValue = wrappedValue
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

fileprivate extension RJSLib {
    final class MyViewController {
        @RJSLib.UsesAutoLayout
        var label = UILabel()
    }
}
#endif
