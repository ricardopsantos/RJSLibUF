//
//  Created by Ricardo Santos on 07/03/2021.
//

import Foundation
import SwiftUI

//
// https://prafullkumar77.medium.com/building-pure-swiftui-search-bar-with-uikit-like-animations-2480724e8c39
//

public extension RJS_Designables_SwiftUI {

    struct SearchBar: View {
        @Binding var text: String
        @Binding var isEditing: Bool
        
        init(text: Binding<String>, isEditing: Binding<Bool>) {
            self._text = text
            self._isEditing = isEditing
        }

        public var body: some View {
            HStack {
                TextField("Search Country...", text: $text)
                    .padding(7.5)
                    .padding(.horizontal, 20)
                    .background(Color(.systemGray6))
                    .cornerRadius(7.5)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 7.5)
                            
                            if isEditing && text.count != 0 {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 7.5)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        withAnimation {
                            self.isEditing = true
                        }
                    }
                
                if isEditing {
                    Button(action: {
                        withAnimation {
                            self.isEditing = false
                            self.text = ""
                        }
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .animation(.linear(duration: 0.25))
                }
            }
            // iOS 14 only
            //.textCase(.none)
            .frame(height: 50)
            .padding(0)
            .background(
                GeometryReader { proxy in
                    Color(UIColor.systemBackground)
                    .frame(width: proxy.size.width * 1.3, height: 100).fixedSize()
                        .offset(CGSize(width: -20.0, height: -50.0))
            })
        }
    }
}

struct Previews_SearchBar {
    
    struct DemoView: View {
        @State private var searchText = ""
        @State private var isEditing = false
        
        let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
        var body: some View {
            NavigationView {
                List {
                    Section(header: RJS_Designables_SwiftUI.SearchBar(text: $searchText, isEditing: $isEditing),
                    content: {
                        ForEach(countryList.filter({searchText.isEmpty ? true : $0.contains(searchText)}), id: \.self) { country in
                            Text(country)
                        }
                    })
                }
                .navigationBarHidden(isEditing).animation(.linear(duration: 0.25))
            }
        }
    }
   
    #if canImport(SwiftUI) && DEBUG
      struct ViewWithAnyViews: PreviewProvider {
        public static var previews: some View {
            RJS_Designables_SwiftUI.ViewWithAnyViews(
                RJSLibUFDesignables_Preview.shared.allCasesSwiftUI(for: RJS_Designables_SwiftUI.SearchBar.self)
            ).buildPreviews()
        }
    }
    
    struct Preview2: PreviewProvider {
        static var previews: some View { DemoView() }
    }
    #endif
}
