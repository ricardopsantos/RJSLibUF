//
//  Created by Ricardo Santos on 20/02/2021.
//

import Foundation
import UIKit

public extension UILayoutPriority {
    
    /// Creates a priority which is almost required, but not 100%.
    static var almostRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
    
    static var almostNotRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 1)
    }
    
    /// Creates a priority which is not required at all.
    static var notRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 0)
    }
}
