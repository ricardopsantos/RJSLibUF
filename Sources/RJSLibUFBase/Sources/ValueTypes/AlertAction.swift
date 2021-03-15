//
//  Created by Ricardo Santos on 10/03/2021.
//

import Foundation
import UIKit

public extension RJSLib {
    struct AlertAction {
        public let title: String
        public let style: UIAlertAction.Style
        public let action: (() -> Void)?
    }
}

