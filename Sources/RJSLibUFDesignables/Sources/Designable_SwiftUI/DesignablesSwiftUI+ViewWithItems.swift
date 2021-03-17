//
//  Created by Ricardo Santos on 07/03/2021.
//

import Foundation
import SwiftUI

public extension RJS_Designables_SwiftUI {
    struct ViewWithAnyViews: View {
        private var items: [AnyView]
        public init(_ items: [AnyView]) {
            self.items = items
        }
        public var body: some View {
            VStack {
                ForEach((1...items.count), id: \.self) {
                    items.element(at: ($0-1)).padding()
                }
            }
        }
    }
}

#if !os(macOS)
struct Previews_ViewWithAnyViews {
    #if canImport(SwiftUI) && DEBUG
    struct ViewWithAnyViews: PreviewProvider {
        public static var previews: some View {
            RJS_Designables_SwiftUI.ViewWithAnyViews(
                RJSLibUFDesignables_Preview.shared.allCasesSwiftUI(for: RJS_Designables_SwiftUI.ViewWithAnyViews.self)
            ).buildPreviews()
        }
    }
    #endif
}
#endif
