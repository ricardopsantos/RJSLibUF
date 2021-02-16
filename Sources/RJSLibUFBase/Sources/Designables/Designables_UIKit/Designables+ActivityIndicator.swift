//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

#if !os(macOS)
import UIKit
import SwiftUI

public extension RJSLib.Designables.UIKit {
        
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
            
            if let oldContainerView = view.viewWithTag(RJS_Constants.Tags.progressView) {
                oldContainerView.removeFromSuperview()
            }
            containerView.tag = RJS_Constants.Tags.progressView
            view.addSubview(containerView)
            
            if true {
                containerView.edgeToSuperView()
            } else {
                containerView.backgroundColor = .blue
                containerView.translatesAutoresizingMaskIntoConstraints = false
                //containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
                //containerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
                containerView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0.2).isActive = true
                containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.2).isActive = true
                
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
            }
            
            let animationPack1 = RJS_Designables_SwiftUI.LoadingAnimations.Pack1.self
            let animationPack2 = RJS_Designables_SwiftUI.LoadingAnimations.Pack2.self
            switch style {
            case .slidingCircles: containerView.addSubSwiftUIView(animationPack1.SlidingCircles())
            case .horizontalSlidingBar: containerView.addSubSwiftUIView(animationPack1.HorizontalSlidingBar())
            case .verticalBar: containerView.addSubSwiftUIView(animationPack1.VerticalBar())
            case .cicleWithWaves: containerView.addSubSwiftUIView(animationPack1.CicleWithWaves())
            case .pack2_1: containerView.addSubSwiftUIView(animationPack2.ActivityIndicator_V1(isAnimating: true))
            case .pack2_2: containerView.addSubSwiftUIView(animationPack2.ActivityIndicator_V2(isAnimating: .constant(true)))
            case .pack2_3: _ = 1//containerView.addSubSwiftUIView(animationPack2.ActivityIndicator_V3())
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
