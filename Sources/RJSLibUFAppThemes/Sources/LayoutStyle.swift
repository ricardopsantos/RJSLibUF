//
//  Created by Ricardo Santos on 28/01/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public extension UIButton {
    enum RJSLibUFLayoutStyle: CaseIterable {
        case notApplied
        case primary
        case secondary
        case secondaryDestructive
        case accept
        case reject
        case remind
        case inngage
    }
}

public extension UILabel {
    enum RJSLibUFLayoutStyle: CaseIterable {
        case notApplied
        case navigationBarTitle
        case title
        case value
        case text
        case error
    }
}
#endif
