//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIView {
    
    var width: CGFloat { target.width }
    var height: CGFloat { target.height }

    var printableMemoryAddress: String {
        target.printableMemoryAddress
    }
    
    var viewController: UIViewController? { target.viewController }

    func bringToFront() { target.bringToFront() }

    func sendToBack() { target.sendToBack() }
    
    func disableUserInteractionFor(_ seconds: Double, disableAlpha: CGFloat = 0.6) {
        target.disableUserInteractionFor(seconds, disableAlpha: disableAlpha)
    }
}

//
// Hide the implementation and force the use of the `rjs` alias
//

fileprivate extension UIView {
       
    var printableMemoryAddress: String {
        // https://stackoverflow.com/questions/24058906/printing-a-variable-memory-address-in-swift
        "\(Unmanaged.passUnretained(self).toOpaque())"
    }
    
    var width: CGFloat { frame.width }
    var height: CGFloat { frame.height }

    var viewController: UIViewController? {
        if let nextResponder = next as? UIViewController {
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
