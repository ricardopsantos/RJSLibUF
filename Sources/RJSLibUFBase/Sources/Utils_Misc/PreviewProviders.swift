//
//  Created by Ricardo Santos on 03/03/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI

//
// https://finsi-ennes.medium.com/how-to-use-live-previews-in-uikit-204f028df3a9
//

public extension RJSLib {
    struct ViewControllerRepresentable: UIViewControllerRepresentable {
        let viewControllerBuilder: () -> UIViewController
        public init(_ viewControllerBuilder: @escaping () -> UIViewController) {
            self.viewControllerBuilder = viewControllerBuilder
        }
        public func makeUIViewController(context: Context) -> some UIViewController {
            return viewControllerBuilder()
        }
        public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // Not needed
        }
    }
    
    struct ViewRepresentable1: UIViewRepresentable {
        public typealias UIViewType = UIView
        let view: UIViewType
        public init(_ view: UIView) { self.view = view }
        public func makeUIView(context: Context) -> UIViewType { view }
        public func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
    
    struct ViewRepresentable2: UIViewRepresentable {
        let viewBuilder: () -> UIView
        public init(_ viewBuilder: @escaping () -> UIView) {
            self.viewBuilder = viewBuilder
        }
        public func makeUIView(context: Context) -> some UIView {
            viewBuilder()
        }

        public func updateUIView(_ uiView: UIViewType, context: Context) {
            // Not needed
        }
    }
}

struct Previews_ViewControllerRepresentable {
    
    fileprivate class SampleVC: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            let image = UIImage(systemName: "play.circle.fill")
            let imageView = UIImageView(image: image!)
            view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: view.widthAnchor)
            ])
        }
    }
    
    #if canImport(SwiftUI) && DEBUG
    // ViewController Preview
    struct PreviewProvider_1: PreviewProvider {
        static var previews: some View {
            RJS_ViewControllerRepresentable { SampleVC() }
        }
    }
    
    // View Preview
    struct PreviewProvider_2: PreviewProvider {
        static var previews: some View {
            RJS_ViewRepresentable { SampleVC().view }
        }
    }
    #endif
}
#endif
