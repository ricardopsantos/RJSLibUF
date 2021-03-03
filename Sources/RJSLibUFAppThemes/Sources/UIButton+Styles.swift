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
    static var buttonDefaultSize: CGSize { return CGSize(width: 125, height: 44) }

    var layoutStyle: RJS_ButtontStyle {
        set { apply(style: newValue) }
        get { return .notApplied }
    }
    
    func setState(enabled: Bool) {
        isUserInteractionEnabled = enabled
        alpha = enabled ? 1.0 : RJS_FadeType.disabledUIElementDefaultValue.rawValue
    }

    func apply(style: RJS_ButtontStyle) {
        switch style {
        case .notApplied  : _ = 1
        case .primary     : applyStylePrimary()
        case .secondary   : applyStyleSecondary()
        case .secondaryDestructive : applyStyleSecondaryDestructive()
        case .inngage     : applyStyleInngage()
        case .accept      : applyStyleAccept()
        case .reject      : applyStyleReject()
        case .remind      : applyStyleRemind()
        }
    }
}

private extension UIButton {

    func applySharedProperties() {
        setState(enabled: true)
        addShadow(shadowType: .regular)
    }

    func applyStyleInngage() {
        applySharedProperties()
        titleLabel?.font = UIButton.defaultFont
        backgroundColor  = RJS_AppBrand1.UIButton.backgroundColorInnGage
        setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorInnGage)
        layer.cornerRadius = 10.0
        clipsToBounds      = true
    }

    func applyStyleAccept() {
        applySharedProperties()
        titleLabel?.font = UIButton.defaultFont
        backgroundColor  = RJS_AppBrand1.accept
        setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorDefault)
        layer.cornerRadius = UIButton.buttonDefaultSize.height / 2
        clipsToBounds      = true
    }

    func applyStyleReject() {
        applySharedProperties()
        titleLabel?.font = UIButton.defaultFont
        backgroundColor  = RJS_AppBrand1.reject
        setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorDefault)
        layer.cornerRadius = UIButton.buttonDefaultSize.height / 2
        clipsToBounds      = true
    }

    func applyStyleRemind() {
        applySharedProperties()
        titleLabel?.font = UIButton.defaultFont
        backgroundColor  = RJS_AppBrand1.remind
        setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorDefault)
        layer.cornerRadius = UIButton.buttonDefaultSize.height / 2
        clipsToBounds      = true
    }
    
    func applyStylePrimary() {
        applySharedProperties()
        titleLabel?.font = UIButton.defaultFont
        backgroundColor  = RJS_AppBrand1.UIButton.backgroundColorDefault
        setTextColorForAllStates(RJS_AppBrand1.UIButton.textColorDefault)
        layer.cornerRadius = UIButton.buttonDefaultSize.height / 2
        clipsToBounds      = true
    }

    func applyStyleSecondary() {
        applySharedProperties()
        titleLabel?.font = UIButton.defaultFont
        backgroundColor  = UIColor.white
        setTextColorForAllStates(RJS_ColorPack3.primary.color)
        layer.borderWidth  = 2
        layer.borderColor  = RJS_AppBrand1.primary.cgColor
        layer.cornerRadius = UIButton.buttonDefaultSize.height / 2
        clipsToBounds      = true
    }

    func applyStyleSecondaryDestructive() {
        applySharedProperties()
        titleLabel?.font = UIButton.defaultFont
        backgroundColor  = UIColor.white
        setTextColorForAllStates(RJS_AppBrand1.error)
        layer.cornerRadius = UIButton.buttonDefaultSize.height / 2
        clipsToBounds      = true
        layer.borderWidth  = 2
        layer.borderColor  = RJS_AppBrand1.error.cgColor
    }

}
#endif
