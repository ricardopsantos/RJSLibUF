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

extension UIView {
    
    @discardableResult
    func stack(_ views: [UIView],
               axis: NSLayoutConstraint.Axis = .vertical,
               width: CGFloat? = nil,
               height: CGFloat? = nil,
               spacing: CGFloat = 0, // Space between subviews
               fill: Bool, // If true, last view try to hanchor on super view (bottom or rigth)
               margin: CGFloat? // Space between subviews and super view margin
    ) -> [NSLayoutConstraint] {
        
        if axis == .vertical, let _ = width, let _ = margin {
            fatalError("Cant have a width and a margin at same time")
        }
        
        if axis == .horizontal, let _ = height, let _ = margin {
            fatalError("Cant have a height and a margin at same time")
        }
        
        var offset: CGFloat = 0
        var previous: UIView?
        var constraints: [NSLayoutConstraint] = []
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            if view.superview == nil {
                addSubview(view)
            }
            
            switch axis {
            case .vertical:
                constraints.append(view.top(to: previous ?? self, previous?.bottomAnchor ?? topAnchor, offset: 0))
                if let margin = margin {
                    constraints.append(view.leftToSuperview(offset: margin))
                }
                if let margin = margin {
                    constraints.append(view.rightToSuperview(offset: -margin))
                }
                if fill, let lastView = views.last, view == lastView {
                    constraints.append(view.bottomToSuperview(offset: offset))
                }
            case .horizontal:
                constraints.append(view.left(to: previous ?? self, previous?.rightAnchor ?? leftAnchor, offset: 0))
                if let margin = margin {
                    constraints.append(view.topToSuperview(offset: margin))
                }
                if let margin = margin {
                    constraints.append(view.bottomToSuperview(offset: -margin))
                }
            if fill, let lastView = views.last, view == lastView {
                constraints.append(view.rightToSuperview(offset: offset))
            }
            @unknown default:
                fatalError()
            }
            
            if let width = width { constraints.append(view.width(width)) }
            if let height = height { constraints.append(view.height(height)) }
			
            offset = spacing
            previous = view
        }
        
        return constraints
    }
}

#endif


