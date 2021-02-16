//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
import SwiftUI
import Combine

public extension RJSLib.Designables {
    struct TestViews {
        private init() {}
                
        public class SomeDelegate: ObservableObject {
            public init() { }
            public var willChange = PassthroughSubject<SomeDelegate, Never>()
            public var didChange = PassthroughSubject<SomeDelegate, Never>()
            public var someValue: String? {
                willSet {
                    willChange.send(self)
                }
                didSet {
                    didChange.send(self)
                }
            }
        }
        
        public struct SwiftUI: View {
            public init(delegate: SomeDelegate) {
                self.delegate = delegate
            }
            
            @ObservedObject var delegate: SomeDelegate

            public var body: some View {
                
                List {
                    Text(String.random(100)).padding()
                    Button("Btn_1") {
                        delegate.someValue = "Btn 1 tap"
                    }
                    Text(String.random(100)).padding()
                    Button("Btn_2") {
                        delegate.someValue = "Btn 2 tap"
                    }
                    Text(String.random(100)).padding()
                }
            }
        }
        
        public static var uiViewController: UIViewController {
            SwiftUI(delegate: SomeDelegate()).viewController
        }
        
        public static var uiView: UIView {
            SwiftUI(delegate: SomeDelegate()).uiView
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
            RJSLib.Designables.TestViews.SwiftUI(delegate: RJSLib.Designables.TestViews.SomeDelegate())
        }
    }
    
    struct Preview2: PreviewProvider {
        static var previews: some View {
            UIKitViewToSwiftUIView()
        }
    }
}
