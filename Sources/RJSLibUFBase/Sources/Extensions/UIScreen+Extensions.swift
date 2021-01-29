//
//  Created by Ricardo Santos on 29/01/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI

public extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
#endif
