//
//  Created by Ricardo Santos on 07/03/2021.
//

import Foundation
import SwiftUI

//
// https://medium.com/geekculture/swiftui-and-the-intermittent-editmode-b714c923f536
// SwiftUI and the Intermittent EditMode
//

public extension RJS_Designables_SwiftUI {
    struct EditModeContext<Content: View> : View {
        @State var editMode: EditMode = .inactive
        var content: Content
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        public var body: some View {
            content.environment(\.editMode, $editMode)
        }
    }
}

#if !os(macOS)
fileprivate struct Previews_EditModeContext {
    
    struct ListView1: View {
        @State var items = ["One", "Two", "Three"]
        var body: some View {
            NavigationView {
                List {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: Text(item), label: {
                            Text(item)
                        })
                    }
                    .onDelete(perform: { _ in })
                    .onMove(perform: { _, _ in })
                }
                .navigationBarTitle("List", displayMode: .inline)
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
    
    struct ListView2: View {
        @State var items = ["One", "Two", "Three"]
        var body: some View {
            NavigationView {
                RJS_Designables_SwiftUI.EditModeContext { // NOTE
                    List {
                        ForEach(items, id: \.self) { item in
                            NavigationLink(
                               destination: Text(item),
                               label: { Text(item) }
                            )
                        }
                        .onDelete(perform: { _ in })
                        .onMove(perform: { indices, newOffset in })
                    }
                    .navigationBarTitle("List", displayMode: .inline)
                    .navigationBarItems(trailing: EditButton())
                }
            }
        }
    }
    
    #if canImport(SwiftUI) && DEBUG
    struct Preview_1: PreviewProvider {
        public static var previews: some View {
            ListView1()
        }
    }
    
    struct Preview_2: PreviewProvider {
        public static var previews: some View {
            ListView2()
        }
    }
    #endif
}
#endif
