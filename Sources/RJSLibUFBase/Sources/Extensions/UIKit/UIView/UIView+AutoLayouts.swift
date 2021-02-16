//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIView {
    func edgeToSuperView() {
        self.target.edgeToSuperView()
    }
}

public extension UIView {
    func edgeToSuperView() {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

#endif
