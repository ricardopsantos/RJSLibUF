//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIViewController {
    var topViewController: UIViewController? {
        return self.target.topViewController
    }
    
    static var topViewController: UIViewController? {
        return UIViewController.topViewController
    }
    
    var isVisible: Bool { self.target.isVisible }
}

public extension UIViewController {

    var topViewController: UIViewController? {
        return UIViewController.topViewController
    }
    
    static var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }
    
    var isVisible: Bool { return self.isViewLoaded && ((self.view.window) != nil) }
    
}
#endif
