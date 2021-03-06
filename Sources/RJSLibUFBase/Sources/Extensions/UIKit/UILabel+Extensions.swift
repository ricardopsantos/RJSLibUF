//
//  Created by Ricardo Santos on 06/08/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UILabel {
    var textAnimated: String? {
        set { target.textAnimated = newValue }
        get { target.text }
    }
}

public extension UILabel {
    var textAnimated: String? {
        set { fadeTransition(); text = newValue ?? "" }
        get { return text }
    }
}

fileprivate extension UILabel {
    func fadeTransition(_ duration: CFTimeInterval=0.5) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type           = .fade
        animation.duration       = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

#endif
