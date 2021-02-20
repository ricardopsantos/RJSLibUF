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

    private let imageView: UIImageView = RJS_UIKitFactory.imageView(urlString: imageURL)
    
    private var delegate = RJSLib.Designables.TestViews.ObservableObjectDelegate()
    private var cancelBag = CancelBag()

    override func loadView() {
        super.loadView()
        prepareLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.layouts.height(200)
        imageView.layouts.width(200)
        imageView.layouts.setSame(.center, as: view)
        
        delegate.didChange.sink { (delegate) in
            print(delegate.someValue)
        }.store(in: cancelBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func displayLoading(style: RJS_Designables_UIKit.ActivityIndicator.Style) {
        view.rjs.startActivityIndicator(style: style)
        RJS_Utils.delay(3) { [weak self] in
            self?.view.rjs.stopActivityIndicator()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //displayLoading(style: .slidingCircles)
        //displayLoading(style: .pack2_2)

        DispatchQueue.executeWithDelay(delay: 3) { [weak self] in
            guard let self = self else { return }
            self.addSubSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate), to: self.imageView)
        }
        
        DispatchQueue.executeWithDelay(delay: 6) { [weak self] in
            guard let self = self else { return }
            self.addSubSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate))
        }
        
        DispatchQueue.executeWithDelay(delay: 9) { [weak self] in
            guard let self = self else { return }
            self.presentSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate), animated: true)
        }
    }
    
    func prepareLayout() {
        view.backgroundColor = .lightGray
    }
}
