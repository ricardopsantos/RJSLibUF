//
//  Created by Ricardo Santos on 26/02/2021.
//

import Foundation
import UIKit

public extension UISearchTextField {
    var textChangesPublisher:  NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self)
    }
}
