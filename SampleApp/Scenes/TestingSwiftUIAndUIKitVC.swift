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

@available(iOS 13.0, *)
struct SwiftUIAndUIKitTestingVC_Preview: PreviewProvider {
    static var previews: some View {
        TestingSwiftUIAndUIKitVC_ViewRepresentable()
    }
}
#endif

class TestingSwiftUIAndUIKitVC: GenericViewController {

    private var delegate = RJSLib.Designables.TestViews.ObservableObjectDelegate()
    private let containerView: UIView = UIView()
    private var cancelBag = CancelBag()

    private lazy var button1: UIButton = {
        let button = UIButton(type: .system)
        button.rjs.setTitleForAllStates("Tap to load inside container")
        button.publisher(for: .touchUpInside).sink { [weak self] button in
            guard let self = self else { return }
            let swiftUIView = RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate)
            swiftUIView.loadInside(view: self.containerView)
        }.store(in: cancelBag)
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton(type: .system)
        button.rjs.setTitleForAllStates("Tap to load inside view controller")
        button.publisher(for: .touchUpInside).sink { [weak self] button in
            guard let self = self else { return }
            let swiftUIView = RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate)
            swiftUIView.loadInside(viewController: self)
        }.store(in: cancelBag)
        return button
    }()
    
    private lazy var button3: UIButton = {
        let button = UIButton(type: .system)
        button.rjs.setTitleForAllStates("Tap to present")
        button.publisher(for: .touchUpInside).sink { [weak self] button in
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
        view.addSubview(containerView)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        containerView.heightToSuperview(multiplier: 0.3)
        containerView.widthToSuperview(multiplier: 0.8)
        containerView.layouts.centerToSuperView()
        containerView.backgroundColor = .red
        button1.layouts.setSame(.centerX, as: view)
        button2.layouts.setSame(.centerX, as: view)
        button3.layouts.setSame(.centerX, as: view)
        button1.layouts.topToBottom(of: containerView)
        button2.layouts.topToBottom(of: button1)
        button3.layouts.topToBottom(of: button2)
        
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
