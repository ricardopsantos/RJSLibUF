//
//  Created by Ricardo Santos on 02/03/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI
//
import RJSLibUFBase
import RJSLibUFAppThemes

public extension RJS_Designables_SwiftUI {
    struct ErrorView1: View {
        private var message: String
        public init(message: String) {
            self.message = message
        }
        public var body: some View {
            Text(message).font(.caption).foregroundColor(Color(RJS_ColorPack3.danger.color)).multilineTextAlignment(.center)
            //Text(message).font(.body).bold().foregroundColor(Color(UIColor.label))
        }
    }
}

//
// MARK: - Previews
//

struct Previews_ErrorView1 {
    #if canImport(SwiftUI) && DEBUG
    struct Preview1: PreviewProvider {
        public static var previews: some View {
            RJS_Designables_SwiftUI.ViewWithAnyViews(
                //RJSLibUFDesignables_Preview.shared.allCasesSwiftUI("\(RJS_Designables_SwiftUI.ErrorView1.self)")
                RJSLibUFDesignables_Preview.shared.allCasesSwiftUI(for: RJS_Designables_SwiftUI.ErrorView1.self)
            ).buildPreviews()
        }
    }
    #endif
}
#endif
