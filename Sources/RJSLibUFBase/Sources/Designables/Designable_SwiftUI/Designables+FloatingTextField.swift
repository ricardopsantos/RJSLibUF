//
//  Created by Ricardo Santos on 02/03/2021.
//

import UIKit
import Foundation
import SwiftUI

public extension RJSLib.Designables.SwiftUI {
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

