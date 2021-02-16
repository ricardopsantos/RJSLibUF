//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIView {
    
    var width: CGFloat { return self.target.width }
    var height: CGFloat { return self.target.height }

    var viewController: UIViewController? { self.target.viewController }

    func bringToFront() { self.target.bringToFront() }

    func sendToBack() {  self.target.sendToBack() }
    
    func disableUserInteractionFor(_ seconds: Double, disableAlpha: CGFloat = 0.6) {
        self.target.disableUserInteractionFor(seconds, disableAlpha: disableAlpha)
    }
}

public extension UIView {
        
    var width: CGFloat { return self.frame.width }
    var height: CGFloat { return self.frame.height }

    var viewController: UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.viewController
        } else {
            return nil
        }
    }

    func bringToFront() { superview?.bringSubviewToFront(self) }

    func sendToBack() { superview?.sendSubviewToBack(self) }
    
    func disableUserInteractionFor(_ seconds: Double, disableAlpha: CGFloat=1) {
        guard self.isUserInteractionEnabled else { return }
        guard seconds > 0 else { return }
        self.isUserInteractionEnabled = false
        self.alpha = disableAlpha
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(seconds)) { [weak self] in
            self?.isUserInteractionEnabled = true
            self?.alpha = 1
        }
    }

}
#endif
