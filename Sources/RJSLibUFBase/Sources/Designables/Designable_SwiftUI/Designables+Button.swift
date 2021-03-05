//
//  Created by Ricardo Santos on 02/03/2021.
//

import Foundation
import SwiftUI

public extension RJSLib.Designables.SwiftUI {
    struct CustomButton: View {
        private let title: String
        private var subTitle: String = ""
        private var action = { }
        public init(title: String, subTitle: String = "", action: @escaping () -> Void = { } ) {
            self.title = title
            self.subTitle = subTitle
            self.action = action
        }
        public var body: some View {
            SwiftUI.Button(action: {
                self.action()
            }, label: {
                Text(title)
                if subTitle != "" {
                    Text(subTitle)
                }
            })
                //.foregroundColor(UIColor.Button.Default.foregroundColor)
                .padding()
                //.background(UIColor.Button.Default.background)
                .cornerRadius(5)
        }
    }
}
