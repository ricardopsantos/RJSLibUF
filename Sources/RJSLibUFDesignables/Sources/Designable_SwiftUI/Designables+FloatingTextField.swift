//
//  Created by Ricardo Santos on 02/03/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI
import UIKit

public extension RJS_Designables_SwiftUI {
    // https://medium.com/swlh/simpler-better-floating-label-textfields-in-swiftui-24f7d06da8b8
    struct FloatingTextField: View {
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
}

//
// MARK: - Previews
//

struct Previews_FloatingTextField {
    struct Preview1: PreviewProvider {
        @State static var valuesFloatingTextField = ""
        public static var previews: some View {
            RJS_Designables_SwiftUI.FloatingTextField(title: "First Name", text: $valuesFloatingTextField).buildPreviews()
        }
    }
}

#endif
