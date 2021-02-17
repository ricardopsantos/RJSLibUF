//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

///////////// UTILS DEV /////////////

public extension RJSLibExtension where Target == UIView {
    func removeAllSubviewsRecursive() { target.removeAllSubviewsRecursive() }
    func allSubviewsRecursive<T: UIView>() -> [T] {  target.allSubviewsRecursive() }
    func subViewsWith(tag: Int, recursive: Bool) -> [UIView] { target.subViewsWith(tag: tag, recursive: recursive) }
}

public extension UIView {
    
    func removeAllSubviewsRecursive() {
        let allViews = UIView.allSubviewsRecursive(from: self) as [UIView]
        _ = allViews.map { (some) -> Void in
            some.removeFromSuperview()
        }
    }
    
    func subViewsWith(tag: Int, recursive: Bool) -> [UIView] {
        if recursive {
            return UIView.allSubviewsRecursive(from: self).filter { $0.tag == tag }
        } else {
            return self.subviews.filter { $0.tag == tag }
        }
    }

    class func allSubviewsRecursive<T: UIView>(from view: UIView) -> [T] {
        return view.subviews.flatMap { subView -> [T] in
            var result = allSubviewsRecursive(from: subView) as [T]
            if let view = subView as? T {
                result.append(view)
            }
            return result
        }
    }
    
    func allSubviewsRecursive<T: UIView>() -> [T] { UIView.allSubviewsRecursive(from: self) as [T] }
 
}

#endif
