//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
import LocalAuthentication
//
import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFAppThemes
import RJSLibUFBaseVIP

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct SwiftUIAndUIKitVC_ViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return VC.SwiftUIAndUIKitVC().view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
    }
}

struct SwiftUIAndUIKitTestingVC_Preview: PreviewProvider {
    static var previews: some View {
        SwiftUIAndUIKitVC_ViewRepresentable()
    }
}
#endif

extension VC {
    class SwiftUIAndUIKitVC: GenericViewController {

        private var delegate = RJSLib.Designables.TestViews.ObservableObjectDelegate()

        private lazy var containerView1: UIView = { UIView() }()
        private lazy var containerView2: UIView = { UIView() }()
        
        private lazy var button1: UIButton = { RJS_UIFactory.button(title: "Load SwiftUIView inside container", style: .primary) }()
        private lazy var button2: UIButton = { RJS_UIFactory.button(title: "Load SwiftUIView inside self", style: .primary) }()
        private lazy var button3: UIButton = { RJS_UIFactory.button(title: "Present SwiftUIView", style: .primary) }()
        
        override func prepareLayout() {
            view.backgroundColor = .white
            view.addSubview(containerView1)
            
            let margin: CGFloat = 16

            containerView1.layouts.topToSuperview(offset: margin)
            containerView1.layouts.leftToSuperview(offset: margin)
            containerView1.layouts.rightToSuperview(offset: -margin)
            containerView1.layouts.bottomToSuperview(offset: margin)

            containerView1.layouts.stackVertical([containerView2, button1, button2, button3], spacing: 5, fill: false, margin: 5)
            
            containerView2.layouts.leftToSuperview()
            containerView2.layouts.rightToSuperview()
            containerView2.layouts.height(200)
            _ = view.rjs.allSubviews.filter({ $0.isKind(of: UIButton.self) }).map { $0.layouts.height(44) }
        }
        
        override func setupFRP() {
            delegate.didChange.sink { (some) in
                print(some)
            }.store(in: cancelBag)
            
            button1.rjsPublisher(for: .touchUpInside).sink { [weak self] _ in
                guard let self = self else { return }
                let swiftUIView = RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate)
                swiftUIView.loadInside(view: self.containerView2)
            }.store(in: cancelBag)
            
            button2.publisher(for: .touchUpInside).sink { [weak self] _ in
                guard let self = self else { return }
                let swiftUIView = RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate)
                swiftUIView.loadInside(viewController: self)
            }.store(in: cancelBag)
            
            button3.publisher(for: .touchUpInside).sink { [weak self] _ in
                guard let self = self else { return }
                self.presentSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate), animated: true)
            }.store(in: cancelBag)
        }
    }
}
