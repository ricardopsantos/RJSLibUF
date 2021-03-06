//
//  Created by Ricardo Santos on 15/02/2021.
//
#if !os(macOS)
import Foundation
import SwiftUI
//
import RJSLibUFBase
import RJSLibUFAppThemes

public extension RJS_Designables_SwiftUI {
    struct ConnectivityView: View {
        @State var connectivity = ""
        let title: String
        let subTitle: String
        public init(title: String = "No internet connection", subTitle: String) {
            self.title = title
            self.subTitle = subTitle
        }
        public var body: some View {
            Text(connectivity)
                .font(.caption)
                .foregroundColor(Color(UIColor.Pack3.danger.color))
                .multilineTextAlignment(.center)
                .onAppear {
                    RJS_NetworMonitor.shared.monitor.pathUpdateHandler = { path in
                        DispatchQueue.main.async {
                            if path.status == .satisfied {
                                connectivity = ""
                            } else {
                                connectivity = "\(subTitle)\n\n\(subTitle)"
                            }
                        }
                    }
            }
        }
    }
}

//
// MARK: - Previews
//

struct Previews_ConnectivityView {
    struct Preview1: PreviewProvider {
        public static var previews: some View {
            RJS_Designables_SwiftUI.ConnectivityView(subTitle: "subtitle").buildPreviews()
        }
    }
}
#endif
