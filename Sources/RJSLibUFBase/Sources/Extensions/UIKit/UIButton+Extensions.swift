//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIButton {
    func paintImageWith(color: UIColor) { self.target.paintImageWith(color: color) }
    func changeImageColor(to color: UIColor) { self.target.changeImageColor(to: color) }
    func setImageForAllStates(_ image: UIImage, tintColor: UIColor?) { self.target.setImageForAllStates(image, tintColor: tintColor) }
    func disable() { self.target.disable() }
    func enable() { self.target.enable() }
    func setTitleForAllStates(_ title: String) { self.target.setTitleForAllStates(title) }
    func setTextColorForAllStates(_ color: UIColor) { self.target.setTextColorForAllStates(color) }
}

public extension UIButton {
    
    func paintImageWith(color: UIColor) {
        changeImageColor(to: color)
    }

    /// Turn image into template image, and apply color
    func changeImageColor(to color: UIColor) {
        guard let origImage = self.image(for: state) else { return }
        let tintedImage = origImage.withRenderingMode(.alwaysTemplate)
        setImageForAllStates(tintedImage, tintColor: color)
        tintColor = color
    }

    func setImageForAllStates(_ image: UIImage, tintColor: UIColor?) {
        let tintedImage = (tintColor != nil) ? image.withRenderingMode(.alwaysTemplate) : image
        setImage(tintedImage, for: .normal)
        setImage(tintedImage, for: .disabled)
        setImage(tintedImage, for: .highlighted)
        setImage(tintedImage, for: .focused)
        if tintColor != nil {
            changeImageColor(to: tintColor!)
        }
    }
    
    func disable() {
        self.isUserInteractionEnabled = false
        self.fadeTo(0.6)
    }

    func enable() {
        self.isUserInteractionEnabled = true
        self.fadeTo(1)
    }
    
    func setTitleForAllStates(_ title: String) {
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .highlighted)
        self.setTitle(title, for: .selected)
    }
    
    func setTextColorForAllStates(_ color: UIColor) {
        self.titleLabel?.textColor = color
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color, for: .highlighted)
        self.setTitleColor(color, for: .selected)
    }
    
    func onTouchUpInside(autoDisableUserInteractionFor: Double=RJS_Constants.defaultDisableTimeAfterTap, block:@escaping () -> Void) {
        
        class ClosureSleeve {
            let block: () -> Void
            init (_ block: @escaping () -> Void) { self.block = block }
            @objc func invoke () { block() }
        }
        
        self.disableUserInteractionFor(autoDisableUserInteractionFor)
        let sleeve = ClosureSleeve(block)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: .touchUpInside)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    func bumpAndPerform(scale: CGFloat=1.05,
                        disableUserInteractionFor: Double=RJS_Constants.defaultDisableTimeAfterTap,
                        block:@escaping () -> Void) {
        self.disableUserInteractionFor(disableUserInteractionFor)
        UIView.animate(withDuration: RJS_Constants.defaultAnimationsTime/2.0, animations: { [weak self] in
            guard let self = self else {
                RJS_Logs.warning(RJS_Constants.referenceLost, tag: .rjsLib)
                return
            }
            self.transform = CGAffineTransform(scaleX: scale, y: scale) },
                       completion: { _ in
                        UIView.animate(withDuration: RJS_Constants.defaultAnimationsTime/2.0 ,
                                       animations: { self.transform = .identity },
                                       completion: { _ in
                                        block()
                        })
                        
        })
    }
    
}
#endif
