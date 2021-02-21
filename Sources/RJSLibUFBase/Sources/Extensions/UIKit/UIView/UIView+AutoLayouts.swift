//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public struct RJSLayouts<Target> {
    let target: Target
    init(_ target: Target) { self.target = target }
}

public protocol RJSLayoutsCompatible { }

public extension RJSLayoutsCompatible {
    var layouts: RJSLayouts<Self> { return RJSLayouts(self) }                   /* instance extension */
    static var layouts: RJSLayouts<Self>.Type { return RJSLayouts<Self>.self }  /* static extension */
}

extension UIView: RJSLayoutsCompatible { }

//
// MARK: - Getters
//

public extension RJSLayouts where Target: UIView {
    var layoutConstraints: [NSLayoutConstraint] { target.layoutConstraints }
}

//
// MARK: -  Hugging and Compression
//

public extension RJSLayouts where Target: UIView {
    
    // Hugging                =>  Dont want to grow
    // Compression Resistance =>  Dont want to shrink
    func setGrowResistanceWith(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        target.setGrowResistanceWith(priority, for: axis)
    }
    
    func setCompressionResistanceWith(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        target.setCompressionResistanceWith(priority, for: axis)
    }
}

//
// MARK: - Destructive
//

public extension RJSLayouts where Target: UIView {
    func removeLayoutConstraints() {
        target.removeLayoutConstraints()
    }
    
    func remove(constraint: NSLayoutConstraint) {
        target.remove(constraint: constraint)
    }
    
}

//
// MARK: - Sugar
//

public extension RJSLayouts where Target: UIView {
        
    @discardableResult
    func bottom(to view: UIView, margin: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return target.setSame(.bottom, as: view, offset: margin)?.first
    }
    
    @discardableResult
    func top(to view: UIView, margin: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return target.setSame(.top, as: view, offset: margin)?.first
    }
    
    @discardableResult
    func topToBottom(of view: UIView, margin: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return target.setMargin(margin, on: .top, from: view, priority: priority)?.first
    }
    
    @discardableResult
    func topToBottomOfSuperView(margin: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return target.setMargin(margin, on: .top, from: target.superview, priority: priority)?.first
    }
    
    @discardableResult
    func addAndSetup(scrollView: UIScrollView, with stackViewV: UIStackView, hasTopBar: Bool) -> [NSLayoutConstraint]? {
        target.addAndSetup(scrollView: scrollView, with: stackViewV, hasTopBar: hasTopBar)
    }
    
    @discardableResult
    func edgesToSuperView() -> [NSLayoutConstraint]? {
        var result: [NSLayoutConstraint]?
        if let c = setSame(.top, as: target.superview) { result?.append(contentsOf: c) }
        if let c = setSame(.left, as: target.superview) { result?.append(contentsOf: c) }
        if let c = setSame(.right, as: target.superview) { result?.append(contentsOf: c) }
        if let c = setSame(.bottom, as: target.superview) { result?.append(contentsOf: c) }
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
// MARK: - Base
//

public extension RJSLayouts where Target: UIView {
    
    @discardableResult
    func setSame(_ layoutAttribute: RJS_LayoutsAttribute, as view: UIView?, multiplier: CGFloat = 1) -> [NSLayoutConstraint]? {
        target.setSame(layoutAttribute, as: view, multiplier: multiplier)
    }
    
    @discardableResult
    func setLayoutAttribute(_ layoutAttribute: RJS_LayoutsAttribute, with value: CGFloat) -> [NSLayoutConstraint]? {
        target.setLayoutAttribute(layoutAttribute, with: value)
    }
    
    @discardableResult
    func setMargin(_ margin: CGFloat,
                   on layoutAttribute: RJS_LayoutsAttribute,
                   from: UIView?,
                   priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        target.setMargin(margin, on: layoutAttribute, from: from, priority: priority)?.first
    }

    @discardableResult
    func setMargin(_ margin: CGFloat,
                   on layoutAttribute: RJS_LayoutsAttribute,
                   priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        target.setMargin(margin, on: layoutAttribute, from: target.superview, priority: priority)?.first
    }
    
}

//
// MARK: - Private : Hugging and Compression
//

fileprivate extension UIView {
    
    // Hugging                =>  Dont want to grow
    // Compression Resistance =>  Dont want to shrink
    func setGrowResistanceWith(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        setContentHuggingPriority(priority, for: axis)
    }
    
    func setCompressionResistanceWith(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        setContentCompressionResistancePriority(priority, for: axis)
    }
}

//
// MARK: - Private : Destructive
//

fileprivate extension UIView {
    
    func removeLayoutConstraints() {
        _ = layoutConstraints.map { remove(constraint: $0) }
    }
    
    func remove(constraint: NSLayoutConstraint) {
        self.removeConstraint(constraint)
        NSLayoutConstraint.deactivate([constraint])
    }
    
    func removeLayoutConstraintWith(identifier: String) {
        if let old = layoutConstraints.filter({ $0.identifier == identifier }).first {
            remove(constraint: old)
        }
    }
}

//
// MARK: - Private : Getters
//
fileprivate extension UIView {
    
    var layoutConstraints: [NSLayoutConstraint] {
        (self.constraints + (self.superview?.constraints ?? []))
            .filter {
                $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
            }
    }
}

//
// MARK: - Base methods
//

fileprivate extension UIView {
       
    @discardableResult
    func addAndSetup(scrollView: UIScrollView, with stackViewV: UIStackView, hasTopBar: Bool) -> [NSLayoutConstraint]? {
        if scrollView.superview == nil {
            addSubview(scrollView)
        }
        if stackViewV.superview == nil {
            scrollView.addSubview(stackViewV)
        }
        var result: [NSLayoutConstraint]?
        if let c = scrollView.layouts.edgesToSuperView() {
            result?.append(contentsOf: c)
        }
        if let c = scrollView.layouts.height(screenHeight) {
            result?.append(c)
        }
        if let c = stackViewV.rjs.edgeStackViewToSuperView() {
            result?.append(contentsOf: c)
        }
        return result
    }
    
    @discardableResult
    func activate(constraint: NSLayoutConstraint,
                  with identifier: String,
                  priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        
        removeLayoutConstraintWith(identifier: identifier)
        guard !identifier.trim.isEmpty else {
            fatalError("Empty identifier")
        }
        constraint.identifier = identifier

        if let priority = priority {
            constraint.priority = priority
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
            let identifier = "id__\(#function)_\($0.firstAnchor.className)_\(self.rjs.printableMemoryAddress)_\(from.rjs.printableMemoryAddress)"
            return activate(constraint: $0, with: identifier)
        }
    }
    
    @discardableResult
    func setSame(_ layoutAttribute: RJS_LayoutsAttribute, as view: UIView?, offset: CGFloat = 0, multiplier: CGFloat = 1) -> [NSLayoutConstraint]? {
        guard let view = view else {
            fatalError("Target view is nil")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        switch layoutAttribute {
        case .height  : constraints.append(heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier))
        case .width   : constraints.append(widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier))
        case .top     : constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: offset))
        case .bottom  : constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset))
        case .left    : constraints.append(leftAnchor.constraint(equalTo: view.leftAnchor, constant: offset))
        case .tailing : constraints.append(trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset))
        case .right   : constraints.append(rightAnchor.constraint(equalTo: view.rightAnchor, constant: offset))
        case .leading : constraints.append(leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset))
        case .centerX : constraints.append(centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset))
        case .centerY : constraints.append(centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset))
        case .center  :
            constraints.append(centerYAnchor.constraint(equalTo: view.centerYAnchor))
            constraints.append(centerXAnchor.constraint(equalTo: view.centerXAnchor))
        }
        return constraints.compactMap {
            let identifier = "id__\(#function)_\($0.firstAnchor.className)_\(self.rjs.printableMemoryAddress)_\(view.rjs.printableMemoryAddress)"
            return activate(constraint: $0, with: identifier)
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
            let identifier = "id__\(#function)_\($0.firstAnchor.className)_\($0.firstAttribute.rawValue)_\(self.rjs.printableMemoryAddress)"
            return activate(constraint: $0, with: identifier)
        }
    }

}
#endif
