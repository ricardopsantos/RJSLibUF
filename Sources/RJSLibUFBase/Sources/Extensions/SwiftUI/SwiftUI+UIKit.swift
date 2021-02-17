//
//  Created by Ricardo Santos on 14/02/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI

//
// References:
// https://www.avanderlee.com/swiftui/integrating-swiftui-with-uikit/
//

public extension View {
    
    // SwiftUIView -> UIViewController
    var viewController: UIViewController {
        UIHostingController(rootView: self)
    }
    
    // SwiftUIView -> UIView
    var uiView: UIView {
        viewController.view
    }
}

public extension UIView {
    
    func addSubSwiftUIView<Content>(_ swiftUIView: Content) where Content: View {
        if let view = swiftUIView.viewController.view {
            self.addSubview(view)
            view.edgesToSuperView()
        }
    }
}

public extension UIViewController {

    /// Add a SwiftUI `View` as a child of the input `UIView`.
    /// - Parameters:
    ///   - swiftUIView: The SwiftUI `View` to add as a child.
    ///   - view: The `UIView` instance to which the view should be added.
    func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content: View {
        let hostingController = swiftUIView.viewController
        if let newView = hostingController.view {
            
            // Add as a child of the current view controller.
            addChild(hostingController)

            // Add the SwiftUI view to the view controller view hierarchy.
            view.addSubview(newView)
            newView.edgesToSuperView()

            // Notify the hosting controller that it has been moved to the current view controller.
            hostingController.didMove(toParent: self)
        }
    }
    
    func addSubSwiftUIView<Content>(_ swiftUIView: Content) where Content: View {
        addSubSwiftUIView(swiftUIView, to: view)
    }
    
    func presentSwiftUIView<Content>(_ swiftUIView: Content,
                                     modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                                     animated: Bool = true,
                                     completion: (() -> Void)? = nil) where Content: View {
        let viewController = swiftUIView.viewController
        viewController.modalPresentationStyle = modalPresentationStyle
        present(swiftUIView.viewController, animated: animated, completion: completion)
    }
}
#endif
