//
//  Created by Ricardo Santos on 15/02/2021.
//

import Foundation
import SwiftUI

public extension RJSLib.Designables.SwiftUI {
    struct ConnectivityView: View {
        @State var connectivity = ""
        let subTitle: String
        public init(subTitle: String) {
            self.subTitle = subTitle
        }
        public var body: some View {
            Text(connectivity)
                .font(.caption)
                .foregroundColor(Color.red)
                .multilineTextAlignment(.center)
                .onAppear {
                    RJS_NetworMonitor.shared.monitor.pathUpdateHandler = { path in
                        DispatchQueue.main.async {
                            if path.status == .satisfied {
                                self.connectivity = ""
                            } else {
                                self.connectivity = "No internet connection\n(\(self.subTitle))"
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
            RJS_Designables_SwiftUI.ConnectivityView(subTitle: "subtitle")
        }
    }
}
