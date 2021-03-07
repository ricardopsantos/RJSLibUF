//
//  Created by Ricardo Santos on 06/08/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension UILabel {
    
    var layoutStyle: RJS_LabelStyle {
        set { apply(style: newValue) }
        get { return .notApplied }
    }

    func apply(style: RJS_LabelStyle) {
        let navigationBarTitle = { [weak self] in
            self?.textColor       = RJS_AppBrand1.TopBar.titleColor
            self?.font            = RJS_Fonts.Styles.headingMedium.rawValue
        }
        let title = { [weak self] in
            self?.textColor       = RJS_AppBrand1.UILabel.lblTextColor
            self?.font            = RJS_Fonts.Styles.paragraphBold.rawValue
        }
        let value = { [weak self] in
            self?.textColor       = RJS_AppBrand1.UILabel.lblTextColor.withAlphaComponent(RJS_FadeType.superLight.rawValue)
            self?.font            = RJS_Fonts.Styles.paragraphSmall.rawValue
        }
        let text = { [weak self] in
            self?.textColor       = RJS_AppBrand1.UILabel.lblTextColor
            self?.font            = RJS_Fonts.Styles.caption.rawValue
        }
        let error = { [weak self] in
            self?.textColor       = RJS_AppBrand1.error
            self?.font            = RJS_Fonts.Styles.captionSmall.rawValue
        }
        switch style {
        case .notApplied         : _ = 1
        case .navigationBarTitle : navigationBarTitle()
        case .title              : title()
        case .value              : value()
        case .text               : text()
        case .error              : error()
        }
    }
}

public extension UILabel {
    /// Given a label with a style X, and with a subString, will apply a diferent style on the subString only
    func applyStyle(_ subStyle: RJS_LabelStyle, onSubString subString: String) {
        guard !subString.trim.isEmpty else { return }
        let subLabel = UILabel()
        subLabel.layoutStyle = subStyle

        let baseStyleAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        let subStyleAttributes  = [NSAttributedString.Key.font: subLabel.font, NSAttributedString.Key.foregroundColor: subLabel.textColor]

        // Get original text
        var originalText = ""
        if text != nil {
            originalText = text!
        }
        if attributedText?.string != nil {
            originalText = attributedText!.string
        }

        // Prepare sub-string. Should is be upperced or lowercased?
        var subStringEscaped = subString

        if originalText.uppercased() == originalText {
            // base text is uppercased!
            subStringEscaped = subStringEscaped.uppercased()
        }

        if originalText.lowercased() == originalText {
            // base text is lowercased!
            subStringEscaped = subStringEscaped.lowercased()
        }

        guard !originalText.trim.isEmpty else { return }

        let mainStyleAttributedString = NSMutableAttributedString(string: originalText, attributes: baseStyleAttributes as [NSAttributedString.Key: Any])
        let subStyleAttributedString  = NSMutableAttributedString(string: subStringEscaped, attributes: subStyleAttributes as [NSAttributedString.Key: Any])

        // Get range of text to replace
        guard let range = mainStyleAttributedString.string.range(of: subStringEscaped) else {
            // Not found
            return
        }
        let nsRange = NSRange(range, in: mainStyleAttributedString.string)
        mainStyleAttributedString.replaceCharacters(in: nsRange, with: subStyleAttributedString)

        text = nil
        attributedText = mainStyleAttributedString
    }
    
}

#endif
