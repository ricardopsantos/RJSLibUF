//
//  Created by Ricardo Santos on 02/03/2021.
//

import Foundation
import SwiftUI

public extension RJSLib.Designables.SwiftUI {
    struct ErrorView: View {
        private var message: String
        public init(message: String) {
            self.message = message
        }
        public var body: some View {
            Text(message).font(.caption).foregroundColor(Color.red).multilineTextAlignment(.center)
            //Text(message).font(.body).bold().foregroundColor(Color(UIColor.label))
        }
    }
}
