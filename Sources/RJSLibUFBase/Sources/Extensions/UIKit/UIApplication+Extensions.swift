//
//  UIApplication+Extensions.swift
//  RJPSLib
//
//  Created by Ricardo Santos on 27/05/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension RJSLibExtension where Target == UIApplication {
    var topViewController: UIViewController? { target.topViewController }
    var isInBackgroundOrInactive: Bool? { target.isInBackgroundOrInactive }
    
    static func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        UIApplication.topViewController(base: base)
    }
}

public extension UIApplication {

    var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    var isInBackgroundOrInactive: Bool {
        switch applicationState {
        case .inactive, .background:
            return true
        case .active:
            return false
        default:
            return false
        }
    }
}
#endif
