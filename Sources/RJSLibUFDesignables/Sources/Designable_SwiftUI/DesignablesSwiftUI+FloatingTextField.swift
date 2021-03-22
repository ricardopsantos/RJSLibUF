//
//  Created by Ricardo Santos on 02/03/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI
import UIKit

public extension RJS_Designables_SwiftUI {
    // https://medium.com/swlh/simpler-better-floating-label-textfields-in-swiftui-24f7d06da8b8
    struct FloatingTextField1: View {
        let title: String
        let text: Binding<String>
        public var body: some View {
            ZStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(text.wrappedValue.isEmpty ? Color(.placeholderText) : .accentColor)
                    .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                    .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.75, anchor: .leading)
                TextField("", text: text)
            }
            .padding(.top, 15)
            .animation(.spring(response: 0.4, dampingFraction: 0.3))
        }
    }
    
    struct FloatingTextField2: View {
        let textFieldHeight: CGFloat = 50
        private let placeHolderText: String
        @Binding var text: String
        @State private var isEditing = false
        public init(placeHolder: String, text: Binding<String>) {
            self._text = text
            self.placeHolderText = placeHolder
        }
        var shouldPlaceHolderMove: Bool {
            isEditing || (text.count != 0)
        }
        public var body: some View {
            ZStack(alignment: .leading) {
                TextField("", text: $text, onEditingChanged: { (edit) in
                    isEditing = edit
                })
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary, lineWidth: 1)
                .frame(height: textFieldHeight))
                .foregroundColor(Color.primary)
                .accentColor(Color.secondary)
                .animation(.linear)
                ///Floating Placeholder
                Text(placeHolderText)
                .foregroundColor(Color.secondary)
                    .background(Color(UIColor.systemBackground))
                .padding(shouldPlaceHolderMove ?
                         EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) :
                         EdgeInsets(top: 0, leading:15, bottom: 0, trailing: 0))
                .scaleEffect(shouldPlaceHolderMove ? 1.0 : 1.2)
                .animation(.linear)
            }
        }
    }
}

//
// MARK: - Previews
//

struct Previews_FloatingTextField {
    #if canImport(SwiftUI) && DEBUG
    struct Preview1: PreviewProvider {
        @State static var valuesFloatingTextField = ""
        public static var previews: some View {
            RJS_Designables_SwiftUI.ViewWithAnyViews(
                RJSLibUFDesignables_Preview.shared.allCasesSwiftUI(for: RJS_Designables_SwiftUI.FloatingTextField1.self)
            ).buildPreviews()
        }
    }
    
    struct Preview2: PreviewProvider {
        @State static var valuesFloatingTextField = ""
        public static var previews: some View {
            RJS_Designables_SwiftUI.ViewWithAnyViews(
                RJSLibUFDesignables_Preview.shared.allCasesSwiftUI(for: RJS_Designables_SwiftUI.FloatingTextField2.self)
            ).buildPreviews()
        }
    }
    #endif
}

#endif
