//
//    MIT License
//
//    Copyright (c) 2017 Robert-Hein Hooijmans <rh.hooijmans@gmail.com>
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.
//

// swiftlint:disable all

#if !os(macOS)

import UIKit

extension TNConstrainable {
    
    @discardableResult
    func center(in view: TNConstrainable, offset: CGPoint = .zero, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        prepareForLayout()
        let constraints = [
            centerX(to: view, offset: offset.x, priority: priority, isActive: isActive),
            centerY(to: view, offset: offset.y, priority: priority, isActive: isActive)
        ]
        return constraints
    }
    
    @discardableResult
    func edges(to view: TNConstrainable, excluding excludedEdge: TNLayoutEdge = .none, insets: UIEdgeInsets = .zero, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        prepareForLayout()
        var constraints: [NSLayoutConstraint] = []
        if !excludedEdge.contains(.top) {
            constraints.append(top(to: view, offset: insets.top, relation: relation, priority: priority, isActive: isActive))
        }
        if !excludedEdge.contains(.left) {
            constraints.append(left(to: view, offset: insets.left, relation: relation, priority: priority, isActive: isActive))
        }
        if !excludedEdge.contains(.bottom) {
            constraints.append(bottom(to: view, offset: -insets.bottom, relation: relation, priority: priority, isActive: isActive))
        }
        if !excludedEdge.contains(.right) {
            constraints.append(right(to: view, offset: -insets.right, relation: relation, priority: priority, isActive: isActive))
        }
        return constraints
    }
    
    @discardableResult
    func size(_ size: CGSize, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        prepareForLayout()
        var constraints: [NSLayoutConstraint] = []
        constraints.append(width(size.width, relation: relation, priority: priority, isActive: isActive))
        constraints.append(height(size.height, relation: relation, priority: priority, isActive: isActive))
        return constraints
    }
    
    @discardableResult
    func size(to view: TNConstrainable, multiplier: CGFloat = 1, insets: CGSize = .zero, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        prepareForLayout()
        let constraints = [
            width(to: view, multiplier: multiplier, offset: insets.width, relation: relation, priority: priority, isActive: isActive),
            height(to: view, multiplier: multiplier, offset: insets.height, relation: relation, priority: priority, isActive: isActive)
        ]
        return constraints
    }
    
    @discardableResult
    func origin(to view: TNConstrainable, insets: UIEdgeInsets = .zero, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        prepareForLayout()
        let constraints = [
            left(to: view, offset: insets.left, relation: relation, priority: priority, isActive: isActive),
            top(to: view, offset: insets.top, relation: relation, priority: priority, isActive: isActive)
        ]
        return constraints
    }
    
    @discardableResult
    func width(_ width: CGFloat, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        switch relation {
        case .equal: return widthAnchor.constraint(equalToConstant: width).with(priority).set(isActive)
        case .equalOrLess: return widthAnchor.constraint(lessThanOrEqualToConstant: width).with(priority).set(isActive)
        case .equalOrGreater: return widthAnchor.constraint(greaterThanOrEqualToConstant: width).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func width(to view: TNConstrainable, _ dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        switch relation {
        case .equal: return widthAnchor.constraint(equalTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return widthAnchor.constraint(lessThanOrEqualTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return widthAnchor.constraint(greaterThanOrEqualTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        }
    }

    @discardableResult
    func widthToHeight(of view: TNConstrainable, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return width(to: view, view.heightAnchor, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func width(min: CGFloat? = nil, max: CGFloat? = nil, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        prepareForLayout()
        var constraints: [NSLayoutConstraint] = []
        if let min = min {
            let constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: min).with(priority)
            constraint.isActive = isActive
            constraints.append(constraint)
        }
        if let max = max {
            let constraint = widthAnchor.constraint(lessThanOrEqualToConstant: max).with(priority)
            constraint.isActive = isActive
            constraints.append(constraint)
        }
        return constraints
    }
    
    @discardableResult
    func height(_ height: CGFloat, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        switch relation {
        case .equal: return heightAnchor.constraint(equalToConstant: height).with(priority).set(isActive)
        case .equalOrLess: return heightAnchor.constraint(lessThanOrEqualToConstant: height).with(priority).set(isActive)
        case .equalOrGreater: return heightAnchor.constraint(greaterThanOrEqualToConstant: height).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func height(to view: TNConstrainable, _ dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        switch relation {
        case .equal: return heightAnchor.constraint(equalTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return heightAnchor.constraint(lessThanOrEqualTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return heightAnchor.constraint(greaterThanOrEqualTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        }
    }

    @discardableResult
    func heightToWidth(of view: TNConstrainable, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return height(to: view, view.widthAnchor, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func height(min: CGFloat? = nil, max: CGFloat? = nil, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        prepareForLayout()
        var constraints: [NSLayoutConstraint] = []
        if let min = min {
            let constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: min).with(priority)
            constraint.isActive = isActive
            constraints.append(constraint)
        }
        if let max = max {
            let constraint = heightAnchor.constraint(lessThanOrEqualToConstant: max).with(priority)
            constraint.isActive = isActive
            constraints.append(constraint)
        }
        return constraints
    }

    @discardableResult
    func aspectRatio(_ ratio: CGFloat, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return widthToHeight(of: self, multiplier: ratio, offset: 0, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func leadingToTrailing(of view: TNConstrainable, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        return leading(to: view, view.trailingAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func leading(to view: TNConstrainable, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        
        switch relation {
        case .equal: return leadingAnchor.constraint(equalTo: anchor ?? view.leadingAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return leadingAnchor.constraint(lessThanOrEqualTo: anchor ?? view.leadingAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return leadingAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.leadingAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func leftToRight(of view: TNConstrainable, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        return left(to: view, view.rightAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func left(to view: TNConstrainable, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        switch relation {
        case .equal: return leftAnchor.constraint(equalTo: anchor ?? view.leftAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return leftAnchor.constraint(lessThanOrEqualTo: anchor ?? view.leftAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return leftAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.leftAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func trailingToLeading(of view: TNConstrainable, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        return trailing(to: view, view.leadingAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func trailing(to view: TNConstrainable, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        switch relation {
        case .equal: return trailingAnchor.constraint(equalTo: anchor ?? view.trailingAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return trailingAnchor.constraint(lessThanOrEqualTo: anchor ?? view.trailingAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return trailingAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.trailingAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func rightToLeft(of view: TNConstrainable, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        return right(to: view, view.leftAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func right(to view: TNConstrainable, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        switch relation {
        case .equal: return rightAnchor.constraint(equalTo: anchor ?? view.rightAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return rightAnchor.constraint(lessThanOrEqualTo: anchor ?? view.rightAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return rightAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.rightAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func topToBottom(of view: TNConstrainable, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        return top(to: view, view.bottomAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func top(to view: TNConstrainable, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        switch relation {
        case .equal: return topAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return topAnchor.constraint(lessThanOrEqualTo: anchor ?? view.topAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return topAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.topAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func bottomToTop(of view: TNConstrainable, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        return bottom(to: view, view.topAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func bottom(to view: TNConstrainable, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, relation: TNConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        switch relation {
        case .equal: return bottomAnchor.constraint(equalTo: anchor ?? view.bottomAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return bottomAnchor.constraint(lessThanOrEqualTo: anchor ?? view.bottomAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return bottomAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.bottomAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func centerX(to view: TNConstrainable, _ anchor: NSLayoutXAxisAnchor? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        let constraint: NSLayoutConstraint
        if let anchor = anchor {
            constraint = centerXAnchor.constraint(equalTo: anchor, constant: offset).with(priority)
        } else {
            constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: multiplier, constant: offset).with(priority)
        }

        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func centerY(to view: TNConstrainable, _ anchor: NSLayoutYAxisAnchor? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        prepareForLayout()
        let constraint: NSLayoutConstraint
        if let anchor = anchor {
            constraint = centerYAnchor.constraint(equalTo: anchor, constant: offset).with(priority)
        } else {
            constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: multiplier, constant: offset).with(priority)
        }
        constraint.isActive = isActive
        return constraint
    }
}

extension UIView {
    func setHugging(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        setContentHuggingPriority(priority, for: axis)
    }
    
    func setCompressionResistance(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        setContentCompressionResistancePriority(priority, for: axis)
    }
}

#endif

