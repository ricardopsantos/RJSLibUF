//
//  Created by Ricardo Santos on 25/02/2021.
//

import Foundation
import UIKit

public protocol RJSCombineCompatibleProtocol { }

/// Extending the `UIControl` types to be able to produce a `UIControl.Event` publisher.

extension UIControl: RJSCombineCompatibleProtocol { }
