//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIView {
    func startLoading(style: RJS_Designables_UIKit.ActivityIndicator.Style) { target.startLoading(style: style) }
    func stopLoading() { target.stopLoading() }
}

public extension UIView {
    func startLoading(style: RJS_Designables_UIKit.ActivityIndicator.Style) {
        RJS_Designables_UIKit.ActivityIndicator.shared.showProgressView(view: self, style: style)
    }
    
    func stopLoading() {
        RJS_Designables_UIKit.ActivityIndicator.shared.hideProgressView()
    }
}

#endif
