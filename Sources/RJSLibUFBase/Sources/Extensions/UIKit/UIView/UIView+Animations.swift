//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIView {
    func startActivityIndicator(style: RJS_Designables_UIKit.ActivityIndicator.Style) {
        self.target.startActivityIndicator(style: style)
    }
    func stopActivityIndicator() {
        self.target.stopActivityIndicator()
    }
}

public extension UIView {
    func startActivityIndicator(style: RJS_Designables_UIKit.ActivityIndicator.Style) {
        RJS_Designables_UIKit.ActivityIndicator.shared.showProgressView(view: self, style: style)
    }
    
    func stopActivityIndicator() {
        RJS_Designables_UIKit.ActivityIndicator.shared.hideProgressView()
    }
}

#endif
