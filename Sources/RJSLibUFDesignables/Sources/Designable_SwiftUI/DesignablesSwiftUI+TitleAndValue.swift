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
    #if canImport(SwiftUI) && DEBUG
    struct Preview1: PreviewProvider {
        public static var previews: some View {
            RJS_Designables_SwiftUI.ViewWithAnyViews(
                RJSLibUFDesignables_Preview.shared.allCasesSwiftUI(for: RJS_Designables_SwiftUI.TitleAndValue.self)
            ).buildPreviews()
        }
    }
    #endif
}

#endif
