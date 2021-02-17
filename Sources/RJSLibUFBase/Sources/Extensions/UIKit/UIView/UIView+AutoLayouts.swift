//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIView {
    func edgesToSuperView() { target.edgesToSuperView() }
    
    func width(_ value: CGFloat) { target.width(value) }
    func widthTo(_ view: UIView?) { target.widthTo(view) }
    func widthToSuperView() { target.widthToSuperView() }
    
    func height(_ value: CGFloat) { target.height(value) }
    func heightTo(_ view: UIView?) { target.heightTo(view) }
    func heightToSuperview() { target.heightToSuperview() }
}

public extension UIView {
    
    func height(_ value: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.heightAnchor.constraint(equalToConstant: value)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func width(_ value: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.widthAnchor.constraint(equalToConstant: value)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func heightTo(_ view: UIView?) {
        guard let view = view else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.heightAnchor.constraint(equalTo: view.heightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func widthTo(_ view: UIView?) {
        guard let view = view else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.widthAnchor.constraint(equalTo: view.widthAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func heightToSuperview() {
        heightTo(superview)
    }
    
    func widthToSuperView() {
        widthTo(superview)
    }
    
    func edgesToSuperView() {
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
