//
//  Created by Ricardo Santos on 17/01/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public typealias ShadowType = FilterStrength
public typealias FadeType = FilterStrength

public enum FilterStrength: CGFloat, CaseIterable {
    case none         = 1
    case superLight   = 0.95
    case regular      = 0.75
    case heavyRegular = 0.6
    case heavy        = 0.4
    case superHeavy   = 0.1
}

// MARK: - FadeType Utils

public extension FadeType {
    static var disabledUIElementDefaultValue: FilterStrength {
        return heavyRegular
    }
}
#endif
