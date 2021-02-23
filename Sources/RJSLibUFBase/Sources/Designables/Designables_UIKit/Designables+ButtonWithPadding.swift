//
//  Created by Ricardo Santos on 23/02/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLib.Designables.UIKit {
    class ButtonWithPadding: UIButton {
        public override var intrinsicContentSize: CGSize {
            super.intrinsicContentSize.addPadding(width: 60, height: 20)
        }
    }
}
#endif
