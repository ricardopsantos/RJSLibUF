//
//  UIDevice+Extensions.swift
//  RJPSLib
//
//  Created by Ricardo Santos on 22/06/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
#if !os(macOS)
import UIKit

public extension RJSLibExtension where Target == UIStackView {
    func add(_ view: UIView) { target.add(view) }
    func addSub(view: UIView) { target.addSub(view: view) }
    func insertArrangedSubview(_ view: UIView, belowArrangedSubview subview: UIView) { target.insertArrangedSubview(view, belowArrangedSubview: subview) }
    func insertArrangedSubview(_ view: UIView, aboveArrangedSubview subview: UIView) { target.insertArrangedSubview(view, aboveArrangedSubview: subview) }
    func removeAllArrangedSubviews() { target.removeAllArrangedSubviews() }
}

public extension UIStackView {

    func edgeStackViewToSuperView() {
        guard self.superview != nil else {
            RJS_Logs.error("\(Self.self) - edgeStackViewToSuperView : No super view for [\(self)]", tag: .rjsLib)
            return
        }
    
        self.edgesToSuperView() // Don't use RJPSLayouts. It will fail if scroll view is inside of stack view with lots of elements
        self.widthToSuperView()  // NEEDS THIS!
    }
        
    func add(_ view: UIView) {
        if view.superview == nil {
            self.addArrangedSubview(view)
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
    }
    
    func addSub(view: UIView) {
        self.add(view)
    }
    
    func insertArrangedSubview(_ view: UIView, belowArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0 + 1)
            }
        }
    }

    func insertArrangedSubview(_ view: UIView, aboveArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0)
            }
        }
    }

    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviewsRecursive, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviewsRecursive + [subview]
        }
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({
            $0.constraints
        }))
        // Remove the views from self
        removedSubviews.forEach({
            $0.removeFromSuperview()
        })
    }
}
#endif
