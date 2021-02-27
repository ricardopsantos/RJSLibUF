//
//  Created by Ricardo Santos on 25/02/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public protocol RJSCombineCompatibleProtocol { }

/// Extending the `UIControl` types to be able to produce a `UIControl.Event` publisher.
extension UIControl: RJSCombineCompatibleProtocol { }

public extension UIControl {
    var rjsCombine: RJSCombineCompatible { return RJSCombineCompatible(target: self) }
}

public struct RJSCombineCompatible {
    public let target: UIControl
}
#endif
