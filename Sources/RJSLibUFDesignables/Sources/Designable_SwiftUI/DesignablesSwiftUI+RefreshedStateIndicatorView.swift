//
//  Created by Ricardo Santos on 07/03/2021.
//

import Foundation
import SwiftUI
//
import RJSLibUFBase

public extension RJS_Designables_SwiftUI {
    struct RefreshedStateIndicatorView: View {
        @State var someBool: Bool = false
        public init() {
            self.someBool = false
        }
        public var body: some View {
            Group {
                if RJS_Utils.onSimulator {
                    VStack {
                        Text("View was refreshed [\(someBool.description)] @ \(Date().hours)h:\(Date().minutes)m:\(Date().seconds)s")
                            .background(Color.random)
                        //CustomButton(title: "Reload") { someBool.toggle() }
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
}

#if !os(macOS)
struct Previews_RefreshAlertView {
    #if canImport(SwiftUI) && DEBUG
    struct RefreshAlertView: PreviewProvider {
        public static var previews: some View {
            RJS_Designables_SwiftUI.ViewWithAnyViews(
                RJSLibUFDesignables_Preview.shared.allCasesSwiftUI(for: RJS_Designables_SwiftUI.RefreshedStateIndicatorView.self)
            ).buildPreviews()
        }
    }
    #endif
}
#endif
