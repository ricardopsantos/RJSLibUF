//
//  Created by Ricardo Santos on 20/02/2021.
//
#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UILayoutPriority {
    static var almostRequired: UILayoutPriority { UILayoutPriority.almostRequired }
    static var almostNotRequired: UILayoutPriority { UILayoutPriority.almostNotRequired }
    static var notRequired: UILayoutPriority  { UILayoutPriority.notRequired }
}

public extension UILayoutPriority {
    
    /// Creates a priority which is almost required, but not 100%.
    static var almostRequired: UILayoutPriority {
        UILayoutPriority(rawValue: 999)
    }
    
    static var almostNotRequired: UILayoutPriority {
        UILayoutPriority(rawValue: 1)
    }
    
    /// Creates a priority which is not required at all.
    static var notRequired: UILayoutPriority {
        UILayoutPriority(rawValue: 0)
    }
}
#endif
