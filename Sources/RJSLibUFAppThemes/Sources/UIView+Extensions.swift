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
        self.layer.shadowColor   = color.cgColor
        self.layer.shadowOpacity = Float(1 - shadowType.rawValue)
        self.layer.shadowOffset  = offset
        self.layer.shadowRadius  = radius
        self.layer.masksToBounds = false
    }

}
#endif
