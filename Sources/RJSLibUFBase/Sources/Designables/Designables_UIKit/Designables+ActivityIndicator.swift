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
            containerView.edgeToSuperView()
            switch style {
            case .slidingCircles: containerView.addSubSwiftUIView(RJS_Designables_SwiftUI.SlidingCircles())
            case .horizontalSlidingBar: containerView.addSubSwiftUIView(RJS_Designables_SwiftUI.HorizontalSlidingBar())
            case .verticalBar: containerView.addSubSwiftUIView(RJS_Designables_SwiftUI.VerticalBar())
            case .cicleWithWaves: containerView.addSubSwiftUIView(RJS_Designables_SwiftUI.CicleWithWaves())
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
