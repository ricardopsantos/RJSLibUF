//
//  Created by Ricardo Santos on 29/01/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI

public extension UIScreen {
    static var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    static var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    static var screenSize: CGSize { UIScreen.main.bounds.size }
}
#endif
