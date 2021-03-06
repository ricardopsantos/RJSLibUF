//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

///////////// UTILS DEV /////////////

public extension RJSLibExtension where Target == UIView {
    func addCorner(radius: CGFloat) { target.addCorner(radius: radius) }
    
    func addCornerCurve(method: CALayerCornerCurve, radius: CGFloat) { target.addCornerCurve(method: method, radius: radius) }
    
    func addBorder(width: CGFloat, color: UIColor) { target.addBorder(width: width, color: color) }
    
    func addBlur(style: UIBlurEffect.Style = .dark) -> UIVisualEffectView { target.addBlur(style: style) }

    func fadeTo(_ value: CGFloat, duration: Double=RJS_Constants.defaultAnimationsTime) { target.fadeTo(value, duration: duration) }
}

public extension UIView {
        
    func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        clipsToBounds     = true
        layoutIfNeeded()
    }
    
    func addCornerCurve(method: CALayerCornerCurve = .circular, radius: CGFloat = 34) {
        layer.cornerCurve = method // .continuous | .circular
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layoutIfNeeded()
    }
    
    func addCorner(radius: CGFloat) {
        addCornerCurve(method: .circular, radius: radius)
    }
    
    // this functions is duplicated
    func addBlur(style: UIBlurEffect.Style = .dark) -> UIVisualEffectView {
        let blurEffectView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.5
        addSubview(blurEffectView)
        return blurEffectView
    }
    
    func fadeTo(_ value: CGFloat, duration: Double=RJS_Constants.defaultAnimationsTime) {
        RJS_Utils.executeInMainTread { [weak self] in
            UIView.animate(withDuration: duration) { [weak self] in
                self?.alpha = value
            }
        }
    }
    
}

#endif
