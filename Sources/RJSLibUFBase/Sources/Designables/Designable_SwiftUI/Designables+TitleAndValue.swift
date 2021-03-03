//
//  Created by Ricardo Santos on 02/03/2021.
//

import UIKit
import Foundation
import SwiftUI

public extension RJSLib.Designables.SwiftUI {
    struct TitleAndValue: View {
        private let title: String
        private let value: String
        public init(title: String, value: String ) {
            self.title = title
            self.value = value
        }
        public var body: some View {
            HStack {
                Text(title).font(.body).bold().foregroundColor(Color(UIColor.label))
                Spacer()
                Text(value).font(.body).foregroundColor(Color(UIColor.secondaryLabel))
            }
        }
    }
}

