//
//  Created by Ricardo Santos on 07/03/2021.
//

import SwiftUI
import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFAppThemes
import RJSLibUFBaseVIP
import RJSLibUFDesignables

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

struct SwiftUIView: View {
    let items = RJSLibUFDesignables_Preview.allCasesSwiftUI
    var body: some View {
        VStack {
            ForEach((0...items.count-1), id: \.self) {
                items.element(at: $0).padding()
            }
        }
    }
}
