//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import UIKit
import SwiftUI
//
import RJSLibUFBase

public extension RJS_Designables_UIKit {
        
    class ActivityIndicator {
        
        private init() { }
        
        static var shared: ActivityIndicator = ActivityIndicator()

        public enum Style {
           case slidingCircles
           case horizontalSlidingBar
           case verticalBar
           case cicleWithWaves
           case pack2_1
           case pack2_2
           case pack2_3
        }
        
        private var containerView = UIView()
        
        public func showProgressView(view: UIView,
                                     loadingViewSizeRatio: CGFloat = 0.1,
                                     style: Style = .cicleWithWaves) {
            let tag = 982763
            if let oldContainerView = view.viewWithTag(tag) {
                oldContainerView.removeFromSuperview()
            }
            containerView.tag = tag
            view.addSubview(containerView)
            containerView.layouts.edgesToSuperview()
            let animationPack1 = RJS_Designables_SwiftUI.LoadingAnimations.Pack1.self
            let animationPack2 = RJS_Designables_SwiftUI.LoadingAnimations.Pack2.self
            switch style {
            case .slidingCircles: containerView.loadWithSwiftUIView(animationPack1.SlidingCircles())
            case .horizontalSlidingBar: containerView.loadWithSwiftUIView(animationPack1.HorizontalSlidingBar())
            case .verticalBar: containerView.loadWithSwiftUIView(animationPack1.VerticalBar())
            case .cicleWithWaves: containerView.loadWithSwiftUIView(animationPack1.CicleWithWaves())
            case .pack2_1: containerView.loadWithSwiftUIView(animationPack2.ActivityIndicator_V1(isAnimating: true))
            case .pack2_2: containerView.loadWithSwiftUIView(animationPack2.ActivityIndicator_V2(isAnimating: .constant(true)))
            case .pack2_3: _ = 1
            }
            UIView.animate(withDuration: RJS_Constants.defaultDelay, animations: { [weak self] in
                self?.containerView.alpha = 1
            })
            
        }
        
        public func hideProgressView() {
            UIView.animate(withDuration: RJS_Constants.defaultDelay, animations: { [weak self] in
                self?.containerView.alpha = 0
                }, completion: { (_) in
                    self.containerView.removeFromSuperview()
            })
        }
    }
}

#endif
