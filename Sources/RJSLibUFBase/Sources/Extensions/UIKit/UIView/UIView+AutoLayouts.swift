//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

public extension UIView {
    var layouts: RJSLayouts {
        return RJSLayouts(target: self)
    }
}

public struct RJSLayouts {
    public let target: UIView
}

//
// MARK: Utils
//

public extension RJSLayouts {

    var layoutConstraints: [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        var _superview = target.superview
        while let superview = _superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == target {
                    constraints.append(constraint)
                }
                if let second = constraint.secondItem as? UIView, second == target {
                    constraints.append(constraint)
                }
            }
            _superview = superview.superview
        }
        constraints.append(contentsOf: target.constraints)
        return constraints
    }
    
    func removeConstraints() {
        layoutConstraints.forEach { (constraint) in
            remove(constraint: constraint)
        }
        target.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func remove(constraint: NSLayoutConstraint) {
        target.removeConstraint(constraint)
        NSLayoutConstraint.deactivate([constraint])
    }
    
    // Hugging => Dont want to grow
    func setGrowResistance(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        target.setContentHuggingPriority(priority, for: axis)
    }
    
    // Compression Resistance => Dont want to shrink
    func setCompressionResistance(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        target.setContentCompressionResistancePriority(priority, for: axis)
    }
    
}

//
// MARK: Composed
//

public extension RJSLayouts {
    
    @discardableResult
    func stack(_ views: [UIView],
               axis: NSLayoutConstraint.Axis = .vertical,
               width: CGFloat? = nil,
               height: CGFloat? = nil,
               spacing: CGFloat = 0,
               fill: Bool = false,
               margin: CGFloat? = nil) -> [NSLayoutConstraint] {
        target.stack(views, axis: axis, width: width, height: height, spacing: spacing, fill: fill, margin: margin)
    }
    
    @discardableResult
    func addAndSetup(scrollView: UIScrollView,
                     with stackViewV: UIStackView,
                     usingSafeArea: Bool) -> [NSLayoutConstraint]? {
        if scrollView.superview == nil {
            target.addSubview(scrollView)
        }
        if stackViewV.superview == nil {
            scrollView.addSubview(stackViewV)
        }
        var result: [NSLayoutConstraint]?
        result?.append(contentsOf: scrollView.layouts.edgesToSuperview())
        //result?.append(scrollView.layouts.height(screenHeight))
        result?.append(scrollView.layouts.heightToSuperview(usingSafeArea: usingSafeArea))
        if let c = stackViewV.rjs.edgeStackViewToSuperView() {
            result?.append(contentsOf: c)
        }
        return result
    }
}

//
// MARK: TinyConstraints
//

public extension RJSLayouts {

    @discardableResult
    func edgesToSuperview(excluding excludedEdge: TNLayoutEdge = .none,
                                 insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return target.edgesToSuperview(excluding: excludedEdge, insets: insets)
    }

    @discardableResult
    func leadingToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                   offset: CGFloat = 0,
                                   relation: RJSLib.ConstraintRelation = .equal,
                                   priority: UILayoutPriority = .required,
                                   isActive: Bool = true,
                                   usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.leadingToSuperview(anchor,
                                         offset: offset,
                                         relation: relation,
                                         priority: priority,
                                         isActive: isActive,
                                         usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func trailingToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                    offset: CGFloat = 0,
                                    relation: RJSLib.ConstraintRelation = .equal,
                                    priority: UILayoutPriority = .required,
                                    isActive: Bool = true,
                                    usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.trailingToSuperview(anchor,
                                          offset: offset,
                                          relation: relation,
                                          priority: priority,
                                          isActive: isActive,
                                          usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func horizontalToSuperview(insets: UIEdgeInsets = .zero,
                               relation: RJSLib.ConstraintRelation = .equal,
                                      priority: UILayoutPriority = .required,
                                      isActive: Bool = true,
                                      usingSafeArea: Bool = false) -> [NSLayoutConstraint] {
        return target.horizontalToSuperview(insets: insets, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func verticalToSuperview(insets: UIEdgeInsets = .zero,
                             relation: RJSLib.ConstraintRelation = .equal,
                                    priority: UILayoutPriority = .required,
                                    isActive: Bool = true,
                                    usingSafeArea: Bool = false) -> [NSLayoutConstraint] {
        return target.verticalToSuperview(insets: insets, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func centerToSuperview(offset: CGPoint = .zero,
                                  priority: UILayoutPriority = .required,
                                  isActive: Bool = true,
                                  usingSafeArea: Bool = false) -> [NSLayoutConstraint] {
        return target.centerInSuperview(offset: offset, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func originToSuperview(insets: UIEdgeInsets = .zero,
                           relation: RJSLib.ConstraintRelation = .equal,
                                  priority: UILayoutPriority = .required,
                                  isActive: Bool = true,
                                  usingSafeArea: Bool = false) -> [NSLayoutConstraint] {
        return target.originToSuperview(insets: insets, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func widthToSuperview(_ dimension: NSLayoutDimension? = nil,
                                 multiplier: CGFloat = 1,
                                 offset: CGFloat = 0,
                                 relation: RJSLib.ConstraintRelation = .equal,
                                 priority: UILayoutPriority = .required,
                                 isActive: Bool = true,
                                 usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.widthToSuperview(dimension,
                                       multiplier: multiplier,
                                       offset: offset,
                                       relation: relation,
                                       priority: priority,
                                       isActive: isActive,
                                       usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func heightToSuperview(_ dimension: NSLayoutDimension? = nil,
                                  multiplier: CGFloat = 1,
                                  offset: CGFloat = 0,
                                  relation: RJSLib.ConstraintRelation = .equal,
                                  priority: UILayoutPriority = .required,
                                  isActive: Bool = true,
                                  usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.heightToSuperview(dimension,
                                        multiplier: multiplier,
                                        offset: offset,
                                        relation: relation,
                                        priority: priority,
                                        isActive: isActive,
                                        usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func leftToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                offset: CGFloat = 0,
                                relation: RJSLib.ConstraintRelation = .equal,
                                priority: UILayoutPriority = .required,
                                isActive: Bool = true,
                                usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.leftToSuperview(anchor,
                                      offset: offset,
                                      relation: relation,
                                      priority: priority,
                                      isActive: isActive,
                                      usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func rightToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                 offset: CGFloat = 0,
                                 relation: RJSLib.ConstraintRelation = .equal,
                                 priority: UILayoutPriority = .required,
                                 isActive: Bool = true,
                                 usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.rightToSuperview(anchor,
                                       offset: offset,
                                       relation: relation,
                                       priority: priority,
                                       isActive: isActive,
                                       usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func topToSuperview(_ anchor: NSLayoutYAxisAnchor? = nil,
                               offset: CGFloat = 0,
                               relation: RJSLib.ConstraintRelation = .equal,
                               priority: UILayoutPriority = .required,
                               isActive: Bool = true,
                               usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.topToSuperview(anchor, offset: offset, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func bottomToSuperview(_ anchor: NSLayoutYAxisAnchor? = nil,
                                  offset: CGFloat = 0,
                                  relation: RJSLib.ConstraintRelation = .equal,
                                  priority: UILayoutPriority = .required,
                                  isActive: Bool = true,
                                  usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.bottomToSuperview(anchor,
                                        offset: offset,
                                        relation: relation,
                                        priority: priority,
                                        isActive: isActive,
                                        usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func centerXToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                   offset: CGFloat = 0,
                                   priority: UILayoutPriority = .required,
                                   isActive: Bool = true,
                                   usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.centerXToSuperview(anchor, offset: offset, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    func centerYToSuperview(_ anchor: NSLayoutYAxisAnchor? = nil,
                                   offset: CGFloat = 0,
                                   priority: UILayoutPriority = .required,
                                   isActive: Bool = true,
                                   usingSafeArea: Bool = false) -> NSLayoutConstraint {
        return target.centerYToSuperview(anchor, offset: offset, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }
}

extension RJSLayouts: TNConstrainable {
    public var topAnchor: NSLayoutYAxisAnchor { return target.topAnchor }
    public var bottomAnchor: NSLayoutYAxisAnchor { return target.topAnchor }
    public var leftAnchor: NSLayoutXAxisAnchor { return target.leftAnchor }
    public var rightAnchor: NSLayoutXAxisAnchor { return target.rightAnchor }
    public var leadingAnchor: NSLayoutXAxisAnchor { return target.leadingAnchor }
    public var trailingAnchor: NSLayoutXAxisAnchor { return target.trailingAnchor }
    public var centerXAnchor: NSLayoutXAxisAnchor { return target.centerXAnchor }
    public var centerYAnchor: NSLayoutYAxisAnchor { return target.centerYAnchor }
    public var widthAnchor: NSLayoutDimension { return target.widthAnchor }
    public var heightAnchor: NSLayoutDimension { return target.heightAnchor }

    @discardableResult
    public func prepareForLayout() -> Self { return RJSLayouts(target: target.prepareForLayout()) }

    @discardableResult
    public func center(in view: TNConstrainable,
                       offset: CGPoint = .zero,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> [NSLayoutConstraint] {
        return target.center(in: view, offset: offset, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func edges(to view: TNConstrainable,
                      insets: UIEdgeInsets = .zero,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> [NSLayoutConstraint] {
        return target.edges(to: view, insets: insets, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func size(_ size: CGSize, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        return target.size(size, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func size(to view: TNConstrainable,
                     multiplier: CGFloat = 1,
                     insets: CGSize = .zero,
                     relation: RJSLib.ConstraintRelation = .equal,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true) -> [NSLayoutConstraint] {
        return target.size(to: view, multiplier: multiplier, insets: insets, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func origin(to view: TNConstrainable,
                       insets: UIEdgeInsets = .zero,
                       relation: RJSLib.ConstraintRelation = .equal,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> [NSLayoutConstraint] {
        return target.origin(to: view, insets: insets, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func width(_ width: CGFloat,
                      relation: RJSLib.ConstraintRelation = .equal,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> NSLayoutConstraint {
        return target.width(width, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func width(to view: TNConstrainable,
                      _ dimension: NSLayoutDimension? = nil,
                      multiplier: CGFloat = 1,
                      offset: CGFloat = 0,
                      relation: RJSLib.ConstraintRelation = .equal,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> NSLayoutConstraint {
        return target.width(to: view, dimension, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func widthToHeight(of view: TNConstrainable,
                              multiplier: CGFloat = 1,
                              offset: CGFloat = 0,
                              relation: RJSLib.ConstraintRelation = .equal,
                              priority: UILayoutPriority = .required,
                              isActive: Bool = true) -> NSLayoutConstraint {
        return target.widthToHeight(of: view, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func width(min: CGFloat? = nil,
                      max: CGFloat? = nil,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> [NSLayoutConstraint] {
        return target.width(min: min, max: max, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func height(_ height: CGFloat,
                       relation: RJSLib.ConstraintRelation = .equal,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> NSLayoutConstraint {
        return target.height(height, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func height(to view: TNConstrainable,
                       _ dimension: NSLayoutDimension? = nil,
                       multiplier: CGFloat = 1,
                       offset: CGFloat = 0,
                       relation: RJSLib.ConstraintRelation = .equal,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> NSLayoutConstraint {
        return target.height(to: view, dimension, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func heightToWidth(of view: TNConstrainable,
                              multiplier: CGFloat = 1,
                              offset: CGFloat = 0,
                              relation: RJSLib.ConstraintRelation = .equal,
                              priority: UILayoutPriority = .required,
                              isActive: Bool = true) -> NSLayoutConstraint {
        return target.heightToWidth(of: view, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func height(min: CGFloat? = nil,
                       max: CGFloat? = nil,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> [NSLayoutConstraint] {
        return target.height(min: min, max: max, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func aspectRatio(_ ratio: CGFloat,
                            relation: RJSLib.ConstraintRelation = .equal,
                            priority: UILayoutPriority = .required,
                            isActive: Bool = true) -> NSLayoutConstraint {
        return target.aspectRatio(ratio, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func leadingToTrailing(of view: TNConstrainable,
                                  offset: CGFloat = 0,
                                  relation: RJSLib.ConstraintRelation = .equal,
                                  priority: UILayoutPriority = .required,
                                  isActive: Bool = true) -> NSLayoutConstraint {
        return target.leadingToTrailing(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func leading(to view: TNConstrainable,
                        _ anchor: NSLayoutXAxisAnchor? = nil,
                        offset: CGFloat = 0,
                        relation: RJSLib.ConstraintRelation = .equal,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true) -> NSLayoutConstraint {
        return target.leading(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func leftToRight(of view: TNConstrainable,
                            offset: CGFloat = 0,
                            relation: RJSLib.ConstraintRelation = .equal,
                            priority: UILayoutPriority = .required,
                            isActive: Bool = true) -> NSLayoutConstraint {
        return target.leftToRight(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func left(to view: TNConstrainable,
                     _ anchor: NSLayoutXAxisAnchor? = nil,
                     offset: CGFloat = 0,
                     relation: RJSLib.ConstraintRelation = .equal,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true) -> NSLayoutConstraint {
        return target.left(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func trailingToLeading(of view: TNConstrainable,
                                  offset: CGFloat = 0,
                                  relation: RJSLib.ConstraintRelation = .equal,
                                  priority: UILayoutPriority = .required,
                                  isActive: Bool = true) -> NSLayoutConstraint {
        return target.trailingToLeading(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func trailing(to view: TNConstrainable,
                         _ anchor: NSLayoutXAxisAnchor? = nil,
                         offset: CGFloat = 0,
                         relation: RJSLib.ConstraintRelation = .equal,
                         priority: UILayoutPriority = .required,
                         isActive: Bool = true) -> NSLayoutConstraint {
        return target.trailing(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func rightToLeft(of view: TNConstrainable,
                            offset: CGFloat = 0,
                            relation: RJSLib.ConstraintRelation = .equal,
                            priority: UILayoutPriority = .required,
                            isActive: Bool = true) -> NSLayoutConstraint {
        return target.rightToLeft(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func right(to view: TNConstrainable,
                      _ anchor: NSLayoutXAxisAnchor? = nil,
                      offset: CGFloat = 0,
                      relation: RJSLib.ConstraintRelation = .equal,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> NSLayoutConstraint {
        return target.right(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func topToBottom(of view: TNConstrainable,
                            offset: CGFloat = 0,
                            relation: RJSLib.ConstraintRelation = .equal,
                            priority: UILayoutPriority = .required,
                            isActive: Bool = true) -> NSLayoutConstraint {
        return target.topToBottom(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func top(to view: TNConstrainable,
                    _ anchor: NSLayoutYAxisAnchor? = nil,
                    offset: CGFloat = 0,
                    relation: RJSLib.ConstraintRelation = .equal,
                    priority: UILayoutPriority = .required,
                    isActive: Bool = true) -> NSLayoutConstraint {
        return target.top(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func bottomToTop(of view: TNConstrainable,
                            offset: CGFloat = 0,
                            relation: RJSLib.ConstraintRelation = .equal,
                            priority: UILayoutPriority = .required,
                            isActive: Bool = true) -> NSLayoutConstraint {
        return target.bottomToTop(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func bottom(to view: TNConstrainable,
                       _ anchor: NSLayoutYAxisAnchor? = nil,
                       offset: CGFloat = 0,
                       relation: RJSLib.ConstraintRelation = .equal,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> NSLayoutConstraint {
        return target.bottom(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func center(to view: TNConstrainable,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true) -> [NSLayoutConstraint] {
        return [
            centerX(to: view, nil, offset: 0, priority: priority, isActive: isActive),
            centerY(to: view, nil, offset: 0, priority: priority, isActive: isActive)
        ]
    }
    
    @discardableResult
    public func centerX(to view: TNConstrainable,
                        _ anchor: NSLayoutXAxisAnchor? = nil,
                        offset: CGFloat = 0,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true) -> NSLayoutConstraint {
        return target.centerX(to: view, anchor, offset: offset, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func centerY(to view: TNConstrainable,
                        _ anchor: NSLayoutYAxisAnchor? = nil,
                        offset: CGFloat = 0,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true) -> NSLayoutConstraint {
        return target.centerY(to: view, anchor, offset: offset, priority: priority, isActive: isActive)
    }
}

#endif

/*
 
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
    func edgesToSuperview() -> [NSLayoutConstraint]? {
        if false {
            var result: [NSLayoutConstraint]?
            if let c = setSame(.top, as: target.superview) { result?.append(contentsOf: c) }
            if let c = setSame(.left, as: target.superview) { result?.append(contentsOf: c) }
            if let c = setSame(.right, as: target.superview) { result?.append(contentsOf: c) }
            if let c = setSame(.bottom, as: target.superview) { result?.append(contentsOf: c) }
            return result
        }
        return target.edgesToSuperview()
    }
    
    @discardableResult
    func centerToSuperView() -> [NSLayoutConstraint]? {
        setSame(.center, as: target.superview)
    }
    
    @discardableResult
    func centerTo(_ view: UIView) -> [NSLayoutConstraint]? {
        setSame(.center, as: view)
    }
    
    @discardableResult
    func width(_ value: CGFloat) -> NSLayoutConstraint? {
        target.setLayoutAttribute(.width, with: value)?.first
    }
    
    @discardableResult
    func widthTo(_ view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint? {
        setSame(.width, as: view, multiplier: multiplier)?.first
    }
    
    @discardableResult
    func widthToSuperview(multiplier: CGFloat = 1) -> NSLayoutConstraint? {
        setSame(.width, as: target.superview, multiplier: multiplier)?.first
    }
    
    @discardableResult
    func height(_ value: CGFloat) -> NSLayoutConstraint? {
        target.setLayoutAttribute(.height, with: value)?.first
    }
    
    @discardableResult
    func heightTo(_ view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint? {
        setSame(.height, as: view, multiplier: multiplier)?.first
    }
    
    @discardableResult
    func heightToSuperview(multiplier: CGFloat = 1) -> NSLayoutConstraint? {
        //target.heightToSuperview(multiplier: multiplier, offset: <#T##CGFloat#>, relation: <#T##ConstraintRelation#>, priority: <#T##LayoutPriority#>, isActive: <#T##Bool#>, usingSafeArea: <#T##Bool#>)
        setSame(.height, as: target.superview, multiplier: multiplier)?.first
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
        if let c = scrollView.layouts.edgesToSuperview() {
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
    func setSame(_ layoutAttribute: RJS_LayoutsAttribute,
                 as view: UIView?,
                 offset: CGFloat = 0,
                 multiplier: CGFloat = 1) -> [NSLayoutConstraint]? {

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
*/
