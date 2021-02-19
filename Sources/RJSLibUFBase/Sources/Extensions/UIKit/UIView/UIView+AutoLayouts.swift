//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIView {
    
    var layoutConstraints: [NSLayoutConstraint] { target.constraints }
    func removeLayoutConstraint() { target.removeLayoutConstraint() }

    func setSame(layoutAttribute: RJS_LayoutsAttribute, as view: UIView?) {
        target.setSame(layoutAttribute: layoutAttribute, as: view)
    }
    
    func setLayoutAttribute(_ layoutAttribute: RJS_LayoutsAttribute, with value: CGFloat) {
        target.setLayoutAttribute(layoutAttribute, with: value)
    }
    
    func edgesToSuperView() { target.edgesToSuperView() }
    
    func width(_ value: CGFloat) { target.width(value) }
    func widthTo(_ view: UIView?) { target.widthTo(view) }
    func widthToSuperView() { target.widthToSuperView() }
    
    func height(_ value: CGFloat) { target.height(value) }
    func heightTo(_ view: UIView?) { target.heightTo(view) }
    func heightToSuperview() { target.heightToSuperview() }
}

public extension UIView {

    func addAndSetup(scrollView: UIScrollView, with stackViewV: UIStackView, hasTopBar: Bool) {
        if scrollView.superview == nil {
            addSubview(scrollView)
        }
        if stackViewV.superview == nil {
            scrollView.addSubview(stackViewV)
        }
        
        scrollView.edgesToSuperView()
        scrollView.height(screenHeight)
        stackViewV.edgeStackViewToSuperView()
    }
    
}

public extension UIView {
    
    func setSame(layoutAttribute: RJS_LayoutsAttribute, as view: UIView?) {
        guard let view = view else {
            preconditionFailure("Target view is nil")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        switch layoutAttribute {
        case .height  : constraints.append(heightAnchor.constraint(equalTo: view.heightAnchor))
        case .width   : constraints.append(widthAnchor.constraint(equalTo: view.widthAnchor))
        case .top     : constraints.append(topAnchor.constraint(equalTo: view.topAnchor))
        case .bottom  : constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor))
        case .left    : constraints.append(leftAnchor.constraint(equalTo: view.leftAnchor))
        case .tailing : _ = ()
        case .right   : constraints.append(rightAnchor.constraint(equalTo: view.rightAnchor))
        case .leading : _ = ()
        case .centerX : constraints.append(centerXAnchor.constraint(equalTo: view.centerXAnchor))
        case .centerY : constraints.append(centerYAnchor.constraint(equalTo: view.centerYAnchor))
        case .center  :
            constraints.append(centerYAnchor.constraint(equalTo: view.centerYAnchor))
            constraints.append(centerXAnchor.constraint(equalTo: view.centerXAnchor))
        }
        if !constraints.isEmpty {
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    func setLayoutAttribute(_ layoutAttribute: RJS_LayoutsAttribute, with value: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        switch layoutAttribute {
        case .height  : constraints.append(heightAnchor.constraint(equalToConstant: value))
        case .width   : constraints.append(widthAnchor.constraint(equalToConstant: value))
        case .top     : _ = ()
        case .bottom  : _ = ()
        case .left    : _ = ()
        case .tailing : _ = ()
        case .right   : _ = ()
        case .leading : _ = ()
        case .centerX : _ = ()
        case .centerY : _ = ()
        case .center  : _ = ()
        }
        if !constraints.isEmpty {
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    func removeLayoutConstraint() {
        layoutConstraints.forEach { (some) in
            self.removeConstraint(some)
            NSLayoutConstraint.deactivate([some])
        }
    }
    
    var layoutConstraints: [NSLayoutConstraint] {
        var tViews: [UIView] = [self]
        var tView: UIView = self
        while let superview = tView.superview {
            tViews.append(superview)
            tView = superview
        }
        return tViews.flatMap({ $0.constraints }).filter { constraint in
            return constraint.firstItem as? UIView == tView || constraint.secondItem as? UIView == tView
        }
    }
    
    func height(_ value: CGFloat) {
        setLayoutAttribute(.height, with: value)
    }
    
    func width(_ value: CGFloat) {
        setLayoutAttribute(.width, with: value)
    }
    
    func heightTo(_ view: UIView?) {
        setSame(layoutAttribute: .height, as: view)
    }
    
    func widthTo(_ view: UIView?) {
        setSame(layoutAttribute: .width, as: view)
    }
    
    func heightToSuperview() {
        heightTo(superview)
    }
    
    func widthToSuperView() {
        widthTo(superview)
    }
    
    func edgesToSuperView() {
        setSame(layoutAttribute: .top, as: superview)
        setSame(layoutAttribute: .left, as: superview)
        setSame(layoutAttribute: .right, as: superview)
        setSame(layoutAttribute: .bottom, as: superview)
    }
}
#endif
