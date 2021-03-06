//
//  Created by Ricardo Santos on 02/03/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI
//
import RJSLibUFBase

public extension RJS_Designables_SwiftUI {
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

struct Previews_TitleAndValue {
    struct TitleAndValue: PreviewProvider {
        public static var previews: some View {
            RJS_Designables_SwiftUI.TitleAndValue(title: "title", value: "value").buildPreviews()
        }
    }
}

#endif
