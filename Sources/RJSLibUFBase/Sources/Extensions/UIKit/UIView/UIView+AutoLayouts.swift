//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UIView {
    
    //
    // Getters
    //
    
    var layoutConstraints: [NSLayoutConstraint] { target.constraints }
    
    //
    // Base
    //
    
    @discardableResult
    func setSame(_ layoutAttribute: RJS_LayoutsAttribute, as view: UIView?) -> [NSLayoutConstraint]? {
        target.setSame(layoutAttribute, as: view)
    }
    
    @discardableResult
    func setLayoutAttribute(_ layoutAttribute: RJS_LayoutsAttribute, with value: CGFloat) -> [NSLayoutConstraint]? {
        target.setLayoutAttribute(layoutAttribute, with: value)
    }
    
    @discardableResult
    func setMargin(_ margin: CGFloat,
                   on layoutAttribute: RJS_LayoutsAttribute,
                   from: UIView?,
                   priority: UILayoutPriority? = nil) -> [NSLayoutConstraint]? {
        target.setMargin(margin, on: layoutAttribute, from: from, priority: priority)
    }

    //
    // Utils
    //
    
    func removeAllLayoutConstraints() {
        target.removeAllLayoutConstraints()
    }

    @discardableResult
    func addAndSetup(scrollView: UIScrollView, with stackViewV: UIStackView, hasTopBar: Bool) -> [NSLayoutConstraint]? {
        target.addAndSetup(scrollView: scrollView, with: stackViewV, hasTopBar: hasTopBar)
    }
    
    @discardableResult
    func edgesToSuperView() -> [NSLayoutConstraint]? {
        var result: [NSLayoutConstraint]?
        if let c = setSame(.top, as: target.superview) {
            result?.append(contentsOf: c)
        }
        if let c = setSame(.left, as: target.superview) {
            result?.append(contentsOf: c)
        }
        if let c = setSame(.right, as: target.superview) {
            result?.append(contentsOf: c)
        }
        if let c = setSame(.bottom, as: target.superview) {
            result?.append(contentsOf: c)
        }
        return result
    }
    
    @discardableResult
    func width(_ value: CGFloat) -> NSLayoutConstraint? {
        target.setLayoutAttribute(.width, with: value)?.first
    }
    
    @discardableResult
    func widthTo(_ view: UIView) -> NSLayoutConstraint? {
        setSame(.width, as: view)?.first
    }
    
    @discardableResult
    func widthToSuperView() -> NSLayoutConstraint? {
        setSame(.width, as: target.superview)?.first
    }
    
    @discardableResult
    func height(_ value: CGFloat) -> NSLayoutConstraint? {
        target.setLayoutAttribute(.height, with: value)?.first
    }
    
    @discardableResult
    func heightTo(_ view: UIView) -> NSLayoutConstraint? {
        setSame(.height, as: view)?.first
    }
    
    @discardableResult
    func heightToSuperview() -> NSLayoutConstraint? {
        setSame(.height, as: target.superview)?.first
    }
}

//
// Hide the implementation and force the use of the `rjs` alias
//

fileprivate extension UIView {
    
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
    
    func removeAllLayoutConstraints() {
        layoutConstraints.forEach { (some) in
            NSLayoutConstraint.deactivate([some])
            self.removeConstraint(some)
        }
    }
    
    func removeConstraintWithIdentifier(_ identifier: String) {
        let toRemove = layoutConstraints.filter { $0.identifier == identifier }.first
        if toRemove != nil {
            self.removeConstraint(toRemove!)
            NSLayoutConstraint.deactivate([toRemove!])
        }
        let constraints = layoutConstraints.filter({ (some) -> Bool in some.identifier == identifier })
        self.superview?.removeConstraints(constraints)
        self.removeConstraints(constraints)
    }
    
    func addAndSetup(scrollView: UIScrollView, with stackViewV: UIStackView, hasTopBar: Bool) -> [NSLayoutConstraint]? {
        if scrollView.superview == nil {
            addSubview(scrollView)
        }
        if stackViewV.superview == nil {
            scrollView.addSubview(stackViewV)
        }
        var result: [NSLayoutConstraint]?
        if let c = scrollView.view.rjs.edgesToSuperView() {
            result?.append(contentsOf: c)
        }
        if let c = scrollView.view.rjs.height(screenHeight) {
            result?.append(c)
        }
        if let c = stackViewV.rjs.edgeStackViewToSuperView() {
            result?.append(contentsOf: c)
        }
        return result
    }
    
    func activate(constraint: NSLayoutConstraint,
                  identifier: String = "",
                  priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        
        removeConstraintWithIdentifier(identifier)
        if !identifier.trim.isEmpty {
            constraint.identifier = identifier
        }
        if let priority = priority {
            constraint.priority   = priority
        }
        NSLayoutConstraint.activate([constraint])
        return constraint
    }
    
    @discardableResult
    func setMargin(_ margin: CGFloat,
                   on layoutAttribute: RJS_LayoutsAttribute,
                   from: UIView?,
                   priority: UILayoutPriority? = nil) -> [NSLayoutConstraint]? {

        guard let from = from else {
           fatalError("Fail to apply margin on [\(layoutAttribute)]. Target view is nil.")
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []

            switch layoutAttribute {
            case .top:
                if from == self.superview {
                    constraints.append(topAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.topAnchor, constant: margin))
                } else {
                    constraints.append(topAnchor.constraint(equalTo: from.bottomAnchor, constant: margin))
                }
            case .bottom:
                let constant = margin
                // Add if statement for safe area check
                if from == self.superview {
                    constraints.append(bottomAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.bottomAnchor, constant: -constant))
                } else {
                    constraints.append(bottomAnchor.constraint(equalTo: from.topAnchor, constant: constant))
                }
            case .left, .tailing:
                let constant = margin
                if from == self.superview {
                    constraints.append(leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: constant))
                } else {
                    constraints.append(leftAnchor.constraint(equalTo: from.rightAnchor, constant: constant))
                }
            case .right, .leading:
                let constant = margin
                if from == self.superview {
                    constraints.append(rightAnchor.constraint(equalTo: self.superview!.rightAnchor, constant: -constant))
                } else {
                    constraints.append(rightAnchor.constraint(equalTo: from.leftAnchor, constant: -constant))
                }
            default:
                _ = 1
            }
        
        return constraints.compactMap {
            activate(constraint: $0, identifier: "id__\(#function)_\(layoutAttribute)_\(from.rjs.printableMemoryAddress)")
        }
    }
    
    @discardableResult
    func setSame(_ layoutAttribute: RJS_LayoutsAttribute, as view: UIView?) -> [NSLayoutConstraint]? {
        guard let view = view else {
            fatalError("Target view is nil")
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
        return constraints.compactMap {
            activate(constraint: $0, identifier: "id_\(#function)_\(layoutAttribute)_\(view.rjs.printableMemoryAddress)")
        }
    }
    
    @discardableResult
    func setLayoutAttribute(_ layoutAttribute: RJS_LayoutsAttribute, with value: CGFloat) -> [NSLayoutConstraint]? {
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
        return constraints.compactMap {
            activate(constraint: $0, identifier: "id__\(#function)_\(layoutAttribute)")
        }
    }

}
#endif
