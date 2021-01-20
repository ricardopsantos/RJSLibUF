//
//  Created by Ricardo Santos on 17/01/2021.
//

import Foundation
#if !os(macOS)
import UIKit
#endif

public enum SizesNames: Int, Codable {
    case size_1 = 2   // Preferred
    case size_2 = 4
    case size_3 = 8   // Unit
    case size_4 = 16  // Base
    case size_5 = 24
    case size_6 = 32  // Preferred
    case size_7 = 40
    case size_8 = 48
    case size_9 = 56
    case size_10 = 64 // Preferred
    case size_11 = 72
    case size_12 = 80
    case size_13 = 88
    case size_14 = 96
    case size_15 = 104
    case size_16 = 112
    case size_17 = 120
    case size_18 = 128
    case size_19 = 136
    case size_20 = 144
    case size_21 = 152
    case size_22 = 160
    
    #if !os(macOS)
    public var cgFloat: CGFloat {
        return CGFloat(self.rawValue)
    }
    #endif
}
