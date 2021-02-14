//
//  Created by Ricardo Santos on 14/02/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI

public extension UIView {
    
    // https://www.avanderlee.com/swiftui/integrating-swiftui-with-uikit/
    func addSubSwiftUIView<Content>(_ swiftUIView: Content) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)

        /// Add as a child of the current view controller.
        self.addSubview(hostingController.view)

        /// Setup the constraints to update the SwiftUI view boundaries.
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: self.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            self.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


public extension UIViewController {

    /// Add a SwiftUI `View` as a child of the input `UIView`.
    /// - Parameters:
    ///   - swiftUIView: The SwiftUI `View` to add as a child.
    ///   - view: The `UIView` instance to which the view should be added.
    /// https://www.avanderlee.com/swiftui/integrating-swiftui-with-uikit/
    func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)

        /// Add as a child of the current view controller.
        addChild(hostingController)

        /// Add the SwiftUI view to the view controller view hierarchy.
        view.addSubview(hostingController.view)

        /// Setup the contraints to update the SwiftUI view boundaries.
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

        /// Notify the hosting controller that it has been moved to the current view controller.
        hostingController.didMove(toParent: self)
    }
}
#endif
