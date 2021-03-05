//
//  Created by Ricardo Santos on 02/03/2021.
//
#if !os(macOS)
import Foundation
import SwiftUI

public extension RJSLib.Designables.SwiftUI {
    struct ListItem: View {
        private let imageName: String
        private let imageColor1: Color?
        private let imageColor2: Color?
        private let title: String
        private let value: String
        public init(title: String,
                    value: String,
                    imageName: String = "",
                    imageColor1: Color? = nil,
                    imageColor2: Color? = nil) {
            self.title = title
            self.value = value
            self.imageName = imageName
            self.imageColor1 = imageColor1
            self.imageColor2 = imageColor2
        }
        public var body: some View {
            HStack {
                if imageName.count > 0 {
                    if imageColor1 != nil && imageColor2 != nil {
                        Image(systemName: imageName)
                            .tint(color: imageColor2 ?? Color.black)
                            .frame(width: 28, height: 28)
                            .background(imageColor1 ?? Color.black)
                            .cornerRadius(6)
                    } else {
                        Image(systemName: imageName)
                            .frame(width: 28, height: 28)
                    }
                }
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.body)
                        .bold()
                        .foregroundColor(Color(UIColor.label))
                    Text(value)
                        .font(.body)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
            }
        }
    }
}
#endif
