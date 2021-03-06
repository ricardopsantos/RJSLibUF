//
//  Created by Ricardo Santos on 02/03/2021.
//

import Foundation
import SwiftUI
//
import RJSLibUFBase

public extension RJS_Designables_SwiftUI {
    struct ErrorView1: View {
        private var message: String
        public init(message: String) {
            self.message = message
        }
        public var body: some View {
            Text(message).font(.caption).foregroundColor(Color(UIColor.Pack3.danger.color)).multilineTextAlignment(.center)
            //Text(message).font(.body).bold().foregroundColor(Color(UIColor.label))
        }
    }
}

//
// MARK: - Previews
//

struct Previews_ErrorView1 {
    struct Preview1: PreviewProvider {
        public static var previews: some View {
            RJS_Designables_SwiftUI.ErrorView1(message: "message").buildPreviews()
        }
    }
}
