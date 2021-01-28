//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//
#if !os(macOS)
import UIKit
import Foundation
//
import RJSLibUFBase

public extension UIButton {

    // Cant be o Designables because the Designables allready import AppTheme
    static var defaultFont: UIFont { RJS_Fonts.Styles.paragraphMedium.rawValue }

    var layoutStyle: RJS_ButtontStyle {
        set { apply(style: newValue) }
        get { return .notApplied }
    }
    
    func setState(enabled: Bool) {
        self.isUserInteractionEnabled = enabled
        self.alpha = enabled ? 1.0 : FadeType.disabledUIElementDefaultValue.rawValue
    }

    func apply(style: RJS_ButtontStyle) {
        switch style {
        case .notApplied  : _ = 1
        case .primary     : self.applyStylePrimary()
        case .secondary   : self.applyStyleSecondary()
        case .secondaryDestructive : self.applyStyleSecondaryDestructive()
        case .inngage     : self.applyStyleInngage()
        case .accept      : self.applyStyleAccept()
        case .reject      : self.applyStyleReject()
        case .remind      : self.applyStyleRemind()
        }
    }
}

private extension UIButton {

    private var buttonDefaultSize: CGSize { return CGSize(width: 125, height: 44) }

    func applySharedProperties() {
        setState(enabled: true)
        addShadow(shadowType: .regular)
    }

    func applyStyleInngage() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = RJS_AppBrand1.UIButton.backgroundColorInnGage
        self.setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorInnGage)
        self.layer.cornerRadius = 10.0
        self.clipsToBounds      = true
    }

    func applyStyleAccept() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = RJS_AppBrand1.accept
        self.setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorDefault)
        self.layer.cornerRadius = buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }

    func applyStyleReject() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = RJS_AppBrand1.reject
        self.setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorDefault)
        self.layer.cornerRadius = buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }

    func applyStyleRemind() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = RJS_AppBrand1.remind
        self.setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorDefault)
        self.layer.cornerRadius = buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }
    
    func applyStylePrimary() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = RJS_AppBrand1.UIButton.backgroundColorDefault
        self.setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorDefault)
        self.layer.cornerRadius = buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }

    func applyStyleSecondary() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = UIColor.white
        self.setTextColorForAllStates(RJS_ColorName.primary.color)
        self.layer.borderWidth  = 2
        self.layer.borderColor  = RJS_AppBrand1.primary.cgColor
        self.layer.cornerRadius = buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }

    func applyStyleSecondaryDestructive() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = UIColor.white
        self.setTextColorForAllStates(RJS_AppBrand1.error)
        self.layer.cornerRadius = buttonDefaultSize.height / 2
        self.clipsToBounds      = true
        self.layer.borderWidth  = 2
        self.layer.borderColor  = RJS_AppBrand1.error.cgColor
    }

}
#endif
