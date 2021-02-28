//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//
#if !os(macOS)
import Foundation
import SwiftUI
import Combine
import UIKit

public extension RJSLib.Designables {
    struct TestViews {
        private init() {}
        
        public struct SwiftUI: View {
            
            @ObservedObject var delegate1: RJS_GenericObservableObjectForHashable<String>
            @ObservedObject var delegate2: RJS_GenericObservableObjectForHashableWithObservers<String>
            public init(delegate1: RJS_GenericObservableObjectForHashable<String> = RJS_GenericObservableObjectForHashable<String>(),
                        delegate2: RJS_GenericObservableObjectForHashableWithObservers<String> = RJS_GenericObservableObjectForHashableWithObservers<String>()) {
                self.delegate1 = delegate1
                self.delegate2 = delegate2
            }
        
            public var body: some View {
                List {
                    Text(String.random(100)).padding()
                    Button("Btn_1") {
                        delegate1.value.send("Btn 1 tap")
                        delegate2.value = "Btn 1 tap"
                    }.padding()
                    Text(String.random(100)).padding()
                    Button("Btn_2") {
                        delegate1.value.send("Btn 2 tap")
                        delegate2.value = "Btn 2 tap"
                    }.padding()
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
#endif
