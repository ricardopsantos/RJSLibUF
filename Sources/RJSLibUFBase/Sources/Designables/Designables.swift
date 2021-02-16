//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
import SwiftUI

public extension RJSLib {
    struct Designables {
        private init() {}
        
        public struct UIKit {
            private init() {}
        }
        
        public struct SwiftUI {
            private init() {}
        }
    }
}

public extension RJSLib.Designables {
    struct TestViews {
        private init() {}
        
        public struct SwiftUI: View {
            public init() { }
            public var body: some View {
                VStack {
                    Text(String.random(100)).padding()
                    Text(String.random(200)).padding()
                    Text(String.random(100)).padding()
                }
            }
        }
        
        public static var uiViewController: UIViewController {
            SwiftUI().viewController
        }
        
        public static var uiView: UIView {
            SwiftUI().uiView
        }
    }
}

//
// MARK: - Previews
//

private struct UIKitViewToSwiftUIView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return RJSLib.Designables.TestViews.uiView
    }
    func updateUIView(_ view: UIView, context: Context) {
        //do your logic here
    }
}

struct Previews_TestViews {
    struct Preview1: PreviewProvider {
        public static var previews: some View {
            RJSLib.Designables.TestViews.SwiftUI()
        }
    }
    
    struct Preview2: PreviewProvider {
        static var previews: some View {
            UIKitViewToSwiftUIView()
        }
    }
}
