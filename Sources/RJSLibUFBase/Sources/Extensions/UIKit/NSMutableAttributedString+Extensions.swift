//
//  NSMutableAttributedString+Extensions.swift
//  RJPSLib
//
//  Created by Ricardo Santos on 21/05/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension RJSLibExtension where Target == NSMutableAttributedString {
    func setFontFace(font: UIFont, color: UIColor? = nil) { target.setFontFace(font: font, color: color) }
}

public extension NSMutableAttributedString {
     func setFontFace(font: UIFont, color: UIColor? = nil) {
        beginEditing()
        self.enumerateAttribute(.font, in: NSRange(location: 0, length: self.length) ) { (value, range, _) in
            if let f = value as? UIFont,
               let newFontDescriptor = f.fontDescriptor .withFamily(font.familyName).withSymbolicTraits(f.fontDescriptor.symbolicTraits) {
                let newFont = UIFont(descriptor: newFontDescriptor, size: font.pointSize )
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                if let color = color {
                    removeAttribute(.foregroundColor, range: range)
                    addAttribute(.foregroundColor, value: color, range: range)
                }
            }
        }
        endEditing()
    }
}
#endif
