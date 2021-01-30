//
//  Created by Ricardo Santos on 20/01/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public extension UIView {
    // this functions is duplicated
    static var defaultShadowColor = UIColor(red: CGFloat(80/255.0), green: CGFloat(88/255.0), blue: CGFloat(93/255.0), alpha: 1)
    static let defaultShadowOffset = CGSize(width: 1, height: 5) // Shadow bellow

    func addShadow(color: UIColor = defaultShadowColor,
                   offset: CGSize = defaultShadowOffset,
                   radius: CGFloat = defaultShadowOffset.height,
                   shadowType: ShadowType = ShadowType.superLight) {
        self.layer.shadowColor   = color.cgColor
        self.layer.shadowOpacity = Float(1 - shadowType.rawValue)
        self.layer.shadowOffset  = offset
        self.layer.shadowRadius  = radius
        self.layer.masksToBounds = false
    }

}
#endif
