//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//
#if !os(macOS)
import UIKit
import Foundation
import SwiftUI
import Combine

public extension RJSLib.Designables {
    struct TestViews {
        private init() {}
        
        public struct SwiftUI: View {
            public init(delegate: RJS_GenericHashableObservableObjectV2<String>) {
                self.delegate = delegate
            }
            
            @ObservedObject var delegate: RJS_GenericHashableObservableObjectV2<String>

            public var body: some View {
                List {
                    Text(String.random(100)).padding()
                    Button("Btn_1") {
                        delegate.value = "Btn 1 tap"
                    }.padding()
                    Text(String.random(100)).padding()
                    Button("Btn_2") {
                        delegate.value = "Btn 2 tap"
                    }.padding()
                    Text(String.random(100)).padding()
                }
            }
        }
        
        public static var uiViewController: UIViewController {
            SwiftUI(delegate: RJS_GenericHashableObservableObjectV2<String>()).viewController
        }
        
        public static var uiView: UIView {
            SwiftUI(delegate: RJS_GenericHashableObservableObjectV2<String>()).uiView
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
            RJSLib.Designables.TestViews.SwiftUI(delegate: RJS_GenericHashableObservableObjectV2<String>())
        }
    }
    
    struct Preview2: PreviewProvider {
        static var previews: some View {
            UIKitViewToSwiftUIView()
        }
    }
}
#endif
