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

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct TestingSwiftUIAndUIKitVC_ViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return TestingSwiftUIAndUIKitVC().view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
    }
}

struct SwiftUIAndUIKitTestingVC_Preview: PreviewProvider {
    static var previews: some View {
        TestingSwiftUIAndUIKitVC_ViewRepresentable()
    }
}
#endif

class TestingSwiftUIAndUIKitVC: GenericViewController {

    private var delegate = RJSLib.Designables.TestViews.ObservableObjectDelegate()
    private var cancelBag = CancelBag()

    private lazy var containerView1: UIView = {
        UIView()
    }()
    
    private lazy var containerView2: UIView = {
        UIView()
    }()
    
    private lazy var button1: UIButton = {
        let button = UIButton(type: .system)
        button.rjs.setTitleForAllStates("Tap to load inside container")
        button.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else { return }
            let swiftUIView = RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate)
            swiftUIView.loadInside(view: self.containerView2)
        }.store(in: cancelBag)
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton(type: .system)
        button.rjs.setTitleForAllStates("Tap to load inside view controller")
        button.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else { return }
            let swiftUIView = RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate)
            swiftUIView.loadInside(viewController: self)
        }.store(in: cancelBag)
        return button
    }()
    
    private lazy var button3: UIButton = {
        let button = UIButton(type: .system)
        button.rjs.setTitleForAllStates("Tap to present")
        button.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else { return }
            let swiftUIView = RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate)
            self.presentSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate), animated: true)
        }.store(in: cancelBag)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        prepareLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView1)
        
        let margin: CGFloat = 16

        containerView1.layouts.topToSuperview(offset: margin)
        containerView1.layouts.leftToSuperview(offset: margin)
        containerView1.layouts.rightToSuperview(offset: -margin)
        containerView1.layouts.bottomToSuperview(offset: margin)

        containerView1.layouts.stack([containerView2, button1, button2, button3])
        containerView2.layouts.widthToSuperview()
        containerView2.layouts.height(200)
        containerView2.backgroundColor = .red
        
        delegate.didChange.sink { (some) in
            print(some)
        }.store(in: cancelBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func prepareLayout() {
        view.backgroundColor = .lightGray
    }
}
