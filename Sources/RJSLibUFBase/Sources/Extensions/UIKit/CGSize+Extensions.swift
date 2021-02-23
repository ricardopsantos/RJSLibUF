//
//  Created by Ricardo Santos on 23/02/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == CGSize {
    func addPadding(width: CGFloat, height: CGFloat) -> CGSize {
        target.addPadding(width: width, height: height)
    }
}

public extension CGSize {
    func addPadding(width: CGFloat, height: CGFloat) -> CGSize {
        CGSize(width: self.width + width, height: self.height + height)
    }
}
#endif
