//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

///////////// UTILS DEV /////////////

public extension RJSLibExtension where Target == UIView {
    func addCorner(radius: CGFloat) {
        self.target.addCorner(radius: radius)
    }
    
    func addBlur(style: UIBlurEffect.Style = .dark) -> UIVisualEffectView {
        self.target.addBlur(style: style)
    }
    
    func fadeTo(_ value: CGFloat, duration: Double=RJS_Constants.defaultAnimationsTime) {
        self.target.fadeTo(value, duration: duration)
    }
}

public extension UIView {
        
    // this functions is duplicated
    func addCorner(radius: CGFloat) {
        self.layoutIfNeeded()
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    // this functions is duplicated
    func addBlur(style: UIBlurEffect.Style = .dark) -> UIVisualEffectView {
        let blurEffectView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.5
        self.addSubview(blurEffectView)
        return blurEffectView
    }
    
    func fadeTo(_ value: CGFloat, duration: Double=RJS_Constants.defaultAnimationsTime) {
        RJS_Utils.executeInMainTread { [weak self] in
            UIView.animate(withDuration: duration) {
                self?.alpha = value
            }
        }
    }
    
}

#endif
