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
    
    func addCornerCurve(method: CALayerCornerCurve, radius: CGFloat) {
        self.target.addCornerCurve(method: method, radius: radius)
    }
    
    func addBorder(width: CGFloat, color: UIColor) {
        self.target.addBorder(width: width, color: color)
    }
    
    func addBlur(style: UIBlurEffect.Style = .dark) -> UIVisualEffectView {
        self.target.addBlur(style: style)
    }
    
    func fadeTo(_ value: CGFloat, duration: Double=RJS_Constants.defaultAnimationsTime) {
        self.target.fadeTo(value, duration: duration)
    }
}

public extension UIView {
        
    func addBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds     = true
        self.layoutIfNeeded()
    }
    func addCornerCurve(method: CALayerCornerCurve = .circular, radius: CGFloat = 34) {
        self.layer.cornerCurve = method // .continuous | .circular
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layoutIfNeeded()
    }
    
    func addCorner(radius: CGFloat) {
        addCornerCurve(method: .circular, radius: radius)
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
