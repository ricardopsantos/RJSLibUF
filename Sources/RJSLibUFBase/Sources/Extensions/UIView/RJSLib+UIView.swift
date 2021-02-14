//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import Foundation
import UIKit

///////////// UTILS DEV /////////////

public extension RJSLibExtension where Target == UIView {
    func startActivityIndicator(style: RJS_Designables_UIKit.ActivityIndicator.Style) {
        RJS_Designables_UIKit.ActivityIndicator.shared.showProgressView(view: self.target, style: style)
    }
    func stopActivityIndicator() {
        RJS_Designables_UIKit.ActivityIndicator.shared.hideProgressView()
    }

    func allSubviews<T: UIView>() -> [T] { return self.target.getAllSubviews() }
    func destroy() { self.target.destroy() }
    func removeAllSubviews() { self.target.removeAllSubviews() }
    func disableUserInteractionFor(_ seconds: Double, disableAlpha: CGFloat=1) {
        self.target.disableUserInteractionFor(seconds, disableAlpha: disableAlpha)
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
    
    var width: CGFloat { return self.frame.width }
    var height: CGFloat { return self.frame.height }

    var viewController: UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.viewController
        } else {
            return nil
        }
    }
    
    // this functions is duplicated
    func addCorner(radius: CGFloat) {
        self.layoutIfNeeded()
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    // this functions is duplicated
    func addBlur(style: UIBlurEffect.Style = .dark) -> UIVisualEffectView {
        let blurEffectView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.5
        self.addSubview(blurEffectView)
        return blurEffectView
    }

    func bringToFront() { superview?.bringSubviewToFront(self) }

    func sendToBack() { superview?.sendSubviewToBack(self) }
    
    func fadeTo(_ value: CGFloat, duration: Double=RJS_Constants.defaultAnimationsTime) {
        RJS_Utils.executeInMainTread { [weak self] in
            UIView.animate(withDuration: duration) {
                self?.alpha = value
            }
        }
    }
    
    func disableUserInteractionFor(_ seconds: Double, disableAlpha: CGFloat=1) {
        guard self.isUserInteractionEnabled else { return }
        guard seconds > 0 else { return }
        self.isUserInteractionEnabled = false
        self.alpha = disableAlpha
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(seconds)) { [weak self] in
            self?.isUserInteractionEnabled = true
            self?.alpha = 1
        }
    }
    
    func removeAllSubviews() {
        let allViews = self.allSubviews() as [UIView]
        _ = allViews.map { (some) -> Void in
            some.removeFromSuperview()
        }
    }

    func destroy() {
        self.removeAllSubviews()
        self.removeFromSuperview()
    }
}

//
// MARK: - SubViews
//

public extension UIView {
    func subViewsWith(tag: Int, recursive: Bool) -> [UIView] {
        if recursive {
            return self.getAllSubviews().filter { $0.tag == tag }
        } else {
            return self.subviews.filter { $0.tag == tag }
        }
    }

    class func getAllSubviews<T: UIView>(from parenView: UIView) -> [T] {
        parenView.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(from: subView) as [T]
            if let view = subView as? T { result.append(view) }
            return result
        }
    }

    class func getAllSubviews(from parenView: UIView, types: [UIView.Type]) -> [UIView] {
        parenView.subviews.flatMap { subView -> [UIView] in
            var result = getAllSubviews(from: subView) as [UIView]
            for type in types {
                if subView.classForCoder == type {
                    result.append(subView)
                    return result
                }
            }
            return result
        }
    }

    func getAllSubviews<T: UIView>() -> [T] { UIView.getAllSubviews(from: self) as [T] }

    func get<T: UIView>(all type: T.Type) -> [T] { UIView.getAllSubviews(from: self) as [T] }

    func get(all types: [UIView.Type]) -> [UIView] { UIView.getAllSubviews(from: self, types: types) }
    
    func allSubviews<T: UIView>() -> [T] { return UIView.allSubviews(view: self) as [T] }
    static func allSubviews<T: UIView>(view: UIView) -> [T] {
        return view.subviews.flatMap { subView -> [T] in
            var result = allSubviews(view: subView) as [T]
            if let view = subView as? T {
                result.append(view)
            }
            return result
        }
    }
}
#endif
