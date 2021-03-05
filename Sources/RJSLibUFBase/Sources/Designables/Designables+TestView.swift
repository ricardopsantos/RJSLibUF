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
    struct TestView1 {
        private init() {}
        
        public static var uiViewController: UIViewController { SwiftUI().viewController }
        public static var uiView: UIView { SwiftUI().uiView }
        
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

    }
    
    struct TestView2 {
        private init() {}
        
        public static var uiViewController: UIViewController { SwiftUI().viewController }
        public static var uiView: UIView { SwiftUI().uiView }
        
        struct SwiftUI: View {
            public init() { }
            @State private var valuesFloatingTextField = ""

            public var body: some View {
                VStack {
                    VStack {
                        Text("Button 1").font(.caption)
                        RJS_Designables_SwiftUI.CustomButton(title: "Title", action: { print("!action!") })
                        Divider()
                    }
                    VStack {
                        Text("FloatingTextField").font(.caption)
                        RJS_Designables_SwiftUI.FloatingTextField(title: "First Name", text: $valuesFloatingTextField)
                        Text(valuesFloatingTextField)
                        Divider()
                    }
                    VStack {
                        Text("TitleAndValue").font(.caption)
                        RJS_Designables_SwiftUI.TitleAndValue(title: "Name", value: "Joe")
                        Divider()
                    }
                    VStack {
                        Text("Error view").font(.caption)
                        RJS_Designables_SwiftUI.ErrorView(message: "Some error")
                        Divider()
                    }
                    Text("ListItem (3 types)").font(.caption)
                    List {
                        RJS_Designables_SwiftUI.ListItem(title: "Option1 title", value: "Option1 value")
                        RJS_Designables_SwiftUI.ListItem(title: "Option2 title", value: "Option2 value", imageName: "paperplane.fill", imageColor1: Color.red, imageColor2: Color.blue)
                        RJS_Designables_SwiftUI.ListItem(title: "Option3 title", value: "Option3 value", imageName: "paperplane.fill")
                    }
                }.padding()
            }
        }
        
    }

}

//
// MARK: - Previews
//

private struct UIKitViewToSwiftUIView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return RJSLib.Designables.TestView1.uiView
    }
    func updateUIView(_ view: UIView, context: Context) {
        //do your logic here
    }
}

struct Previews_TestViews {
    
    struct Preview1: PreviewProvider {
        static var previews: some View {
            UIKitViewToSwiftUIView()
        }
    }
    
    struct Preview3: PreviewProvider {
        static var previews: some View {
            RJSLib.Designables.TestView2.SwiftUI().buildPreviews()
        }
    }
}
#endif
