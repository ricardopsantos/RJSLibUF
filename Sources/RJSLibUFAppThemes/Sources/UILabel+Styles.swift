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
        let navigationBarTitle = {
            self.textColor       = RJS_AppBrand1.TopBar.titleColor
            self.font            = RJS_Fonts.Styles.headingMedium.rawValue
        }
        let title = {
            self.textColor       = RJS_AppBrand1.UILabel.lblTextColor
            self.font            = RJS_Fonts.Styles.paragraphBold.rawValue
        }
        let value = {
            self.textColor       = RJS_AppBrand1.UILabel.lblTextColor.withAlphaComponent(FadeType.superLight.rawValue)
            self.font            = RJS_Fonts.Styles.paragraphSmall.rawValue
        }
        let text = {
            self.textColor       = RJS_AppBrand1.UILabel.lblTextColor
            self.font            = RJS_Fonts.Styles.caption.rawValue
        }
        let error = {
            self.textColor       = RJS_AppBrand1.error
            self.font            = RJS_Fonts.Styles.captionSmall.rawValue
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

#endif
