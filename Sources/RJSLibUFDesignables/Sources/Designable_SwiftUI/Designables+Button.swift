//
//  Created by Ricardo Santos on 02/03/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI
import UIKit
//
import RJSLibUFAppThemes

public extension RJS_Designables_SwiftUI {
    struct CustomButton: View {
        private let title: String
        private var subTitle: String = ""
        private var action = { }
        public init(title: String, subTitle: String = "", action: @escaping () -> Void = { }) {
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
            .foregroundColor(Color(RJS_ColorPack3.onPrimary.color))
            .padding()
            .background(Color(RJS_ColorPack3.primary.color))
            .cornerRadius(5)
        }
    }
}

//
// MARK: - Previews
//

struct Previews_CustomButton {
    #if canImport(SwiftUI) && DEBUG
    struct Preview1: PreviewProvider {
        public static var previews: some View {
            RJS_Designables_SwiftUI.ViewWithAnyViews(
                RJSLibUFDesignables_Preview.allCasesSwiftUI("\(RJS_Designables_SwiftUI.CustomButton.self)")
            ).buildPreviews()
        }
    }
    #endif
}
#endif
