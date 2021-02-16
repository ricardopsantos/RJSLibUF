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
        return DesignablesVC().view
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

class DesignablesVC: GenericViewController {

    private let imageView: UIImageView = RJS_UIKitFactory.imageView(urlString: "http://getwallpapers.com/wallpaper/full/a/0/a/285824.jpg")
    
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
        
        //displayLoading(style: .slidingCircles)
        //displayLoading(style: .pack2_2)
        view.backgroundColor = .red
        //self.presentSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(), animated: true)
        //self.addSubSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(), to: <#T##UIView#>)
        DispatchQueue.executeWithDelay(delay: 3) {
            self.addSubSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(), to: self.imageView)
        }
        
        DispatchQueue.executeWithDelay(delay: 6) {
            self.addSubSwiftUIView(RJSLib.Designables.TestViews.SwiftUI())
        }
        
        DispatchQueue.executeWithDelay(delay: 9) {
            self.presentSwiftUIView(RJSLib.Designables.TestViews.SwiftUI(), animated: true)
        }
    }
    
    func prepareLayout() {
        self.view.backgroundColor = .white
    }
}
