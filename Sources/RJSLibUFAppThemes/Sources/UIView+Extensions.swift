//
//  Created by Ricardo Santos on 20/01/2021.
//

#if !os(macOS)
import Foundation
import UIKit
import RJSLibUFBase

public extension RJSLibExtension where Target == UIView {
    func addShadow(color: UIColor = UIView.defaultShadowColor,
                   offset: CGSize = UIView.defaultShadowOffset,
                   radius: CGFloat = UIView.defaultShadowOffset.height,
                   shadowType: RJS_ShadowType = .superLight) {
        target.addShadow(color: color, offset: offset, radius: radius, shadowType: shadowType)
    }
    
    func addShadowSketch(color: UIColor = .black,
                         alpha: Float = 0.5,
                         x: CGFloat = 0,
                         y: CGFloat = 2,
                         blur: CGFloat = 4,
                         spread: CGFloat = 0) {
        target.layer.addShadowSketch(color: color, alpha: alpha, x: x, y: y, blur: blur, spread: spread)
    }
}

public extension UIView {

    static var defaultShadowColor = UIColor(red: CGFloat(80/255.0), green: CGFloat(88/255.0), blue: CGFloat(93/255.0), alpha: 1)
    static let defaultShadowOffset = CGSize(width: 1, height: 5) // Shadow bellow

    //
    // More about shadows : https://medium.com/swlh/how-to-create-advanced-shadows-in-swift-ios-swift-guide-9d2844b653f8
    //
    
    func addShadow(color: UIColor = defaultShadowColor,
                   offset: CGSize = defaultShadowOffset,
                   radius: CGFloat = defaultShadowOffset.height,
                   shadowType: RJS_ShadowType = .superLight) {
        layer.shadowColor   = color.cgColor
        layer.shadowOpacity = Float(1 - shadowType.rawValue)
        layer.shadowOffset  = offset
        layer.shadowRadius  = radius
        layer.masksToBounds = false
    }
}

public extension CALayer {
    // Extension from: https://stackoverflow.com/questions/34269399/how-to-control-shadow-spread-and-blur
    func addShadowSketch(color: UIColor = UIView.defaultShadowColor,
                         alpha: Float = 0.5,
                         x: CGFloat = 0,
                         y: CGFloat = 2,
                         blur: CGFloat = 4,
                         spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

#endif
