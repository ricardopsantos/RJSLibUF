//
//  Created by Ricardo Santos on 20/02/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIScrollView {
    
}

public extension UIScrollView {
    var view: UIView { (self as UIView) }
}

fileprivate extension UIScrollView {
    
}
#endif
