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
import RJSLibUFALayouts
import RJSLibUFAppThemes

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct DesignablesVCViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return SwiftUIAndUIKitTesting().view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
    }
}

@available(iOS 13.0, *)
struct DesignablesVC_Preview: PreviewProvider {
    static var previews: some View {
        DesignablesVCViewRepresentable()
    }
}
#endif

class SwiftUIAndUIKitTesting: GenericViewController {

    private let imageView: UIImageView = RJS_UIKitFactory.imageView(urlString: "http://getwallpapers.com/wallpaper/full/a/0/a/285824.jpg")
    
    private var delegate = RJS_Designables.TestViews.ObservableObjectDelegate()
    private var cancelBag = CancelBag()

    override func loadView() {
        super.loadView()
        prepareLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        //imageView.edgeToSuperView()
        imageView.rjsALayouts.height(200)
        imageView.rjsALayouts.width(200)
        imageView.rjsALayouts.setSame(.center, as: view)
        
        delegate.didChange.sink { (delegate) in
            // reading selected contact with `delegate.contact`
            print(delegate.someValue)
        }.store(in: cancelBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func displayLoading(style: RJS_Designables_UIKit.ActivityIndicator.Style) {
        (imageView as UIView).rjs.startActivityIndicator(style: style)
        RJS_Utils.delay(3) {  [weak self] in
            self?.view.rjs.stopActivityIndicator()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = .lightGray

        DispatchQueue.executeWithDelay(delay: 3) {
            self.addSubSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate), to: self.imageView)
        }
        
        DispatchQueue.executeWithDelay(delay: 6) {
            self.addSubSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate))
        }
        
        DispatchQueue.executeWithDelay(delay: 9) {
            self.presentSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(delegate: self.delegate), animated: true)
        }
    }
    
    func prepareLayout() {
        self.view.backgroundColor = .white
    }
}
