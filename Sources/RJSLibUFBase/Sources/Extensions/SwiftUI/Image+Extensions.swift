//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import SwiftUI
#if !os(macOS)
import UIKit
#endif

public extension Image {
    func contentMode(_ mode: ContentMode) -> some View {
        self.resizable().aspectRatio(contentMode: mode)
    }

    func tint(color: Color) -> some View {
        self.foregroundColor(color)
    }

    func resize(width: CGFloat, height: CGFloat, alignment: Alignment = .center) -> some View {
        self.resizable().frame(width: width, height: height, alignment: alignment)
    }
}

public enum ImageNames: String, CaseIterable {
    case arrow
    case arrow2 = "arrow.2"
    case arrowCounterClockWise = "arrow.counterclockwise"
    case arrowClockWise = "arrow.clockwise"
    case app
    case bag
    case bell
    case buble
    case cloud
    case clock
    case camera
    case chevron
    case circle
    case envelope
    case ellipsis
    case flame
    case house
    case heart
    case gear
    case location
    case magnifyingglass
    case message
    case minus
    case minusSquare = "minus.square"
    case minusCircle = "minus.circle"
    case mic
    case micCircle = "mic.circle"
    case micSlash = "mic.slash"
    case phone
    case paperplane
    case person
    case personCrop = "person.crop"
    case personCropCircle = "person.crop.circle"
    case personCropSquare = "person.crop.square"
    case plus
    case pause
    case play
    case plusCircle = "plus.circle"
    case plusSquare = "plus.square"
    case star
    case sparkles
    case stop
    case square
    case squareAndArrow = "square.and.arrow"
    case wifi
    case xmark
}

#if !os(macOS)
public extension ImageNames {
    public var name: String {
        self.rawValue
    }

    public var image: Image {
        Image(systemName: "\(self.rawValue)")
    }

    public var imageFill: Image {
        Image(systemName: "\(self.rawValue).fill")
    }

    public var imageBadge: Image {
        Image(systemName: "\(self.rawValue).badge")
    }

    public var imageSquarePath: Image {
        Image(systemName: "\(self.rawValue).squarepath")
    }

    public var imageSquare: Image {
        Image(systemName: "\(self.rawValue).square")
    }

    public var imageCircle: Image {
        Image(systemName: "\(self.rawValue).circle")
    }

    public var imageRight: Image {
        Image(systemName: "\(self.rawValue).right")
    }

    public var imageLeft: Image {
        Image(systemName: "\(self.rawValue).left")
    }

    public var imageUp: Image {
        Image(systemName: "\(self.rawValue).up")
    }

    public var imageDown: Image {
        Image(systemName: "\(self.rawValue).down")
    }
}
#endif

#if !os(macOS)
public struct VisualDocs_ImageName: View {
    public init() { }
    @State var imageNames = ImageNames.allCases
    public var body: some View {
        VStack {
             ScrollView {
                Text("ImageNames").font(.title)
                Divider()
                ForEach(self.imageNames, id: \.self) { imageName in
                    VStack {
                        Divider()
                        HStack {
                            Text(imageName.name).bold()
                            imageName.image.foregroundColor(Color(UIColor.black))
                        }.scaledToFill()
                        HStack {
                            VStack {
                                imageName.imageFill.foregroundColor(Color(UIColor.black))
                                Text(".fill").font(.caption).textColor(Color(UIColor.lightGray))
                            }.scaledToFill()
                            VStack {
                                imageName.imageBadge.foregroundColor(Color(UIColor.black))
                                Text(".badge").font(.caption).textColor(Color(UIColor.lightGray))
                            }.scaledToFill()
                            VStack {
                                imageName.imageSquarePath.foregroundColor(Color(UIColor.black))
                                Text(".squarePath").font(.caption).textColor(Color(UIColor.lightGray))
                            }.scaledToFill()
                            VStack {
                                imageName.imageSquare.foregroundColor(Color(UIColor.black))
                                Text(".square").font(.caption).textColor(Color(UIColor.lightGray))
                            }.scaledToFill()
                            VStack {
                                imageName.imageCircle.foregroundColor(Color(UIColor.black))
                                Text(".circle").font(.caption).textColor(Color(UIColor.lightGray))
                            }.scaledToFill()
                        }.scaledToFill()
                        HStack {
                            VStack {
                                imageName.imageRight.foregroundColor(Color(UIColor.black))
                                Text(".right").font(.caption).textColor(Color(UIColor.lightGray))
                            }.scaledToFill()
                            VStack {
                                imageName.imageLeft.foregroundColor(Color(UIColor.black))
                                Text(".left").font(.caption).textColor(Color(UIColor.lightGray))
                            }.scaledToFill()
                            VStack {
                                imageName.imageUp.foregroundColor(Color(UIColor.black))
                                Text(".up").font(.caption).textColor(Color(UIColor.lightGray))
                            }.scaledToFill()
                            VStack {
                                imageName.imageDown.foregroundColor(Color(UIColor.black))
                                Text(".down").font(.caption).textColor(Color(UIColor.lightGray))
                            }.scaledToFill()
                        }.scaledToFill()
                    }
                }
            }
        }
    }
}

// MARK: - Preview
/*
public struct VisualDocs_ImageName_PreviewProvider: PreviewProvider {
    public static var previews: some View {
        VisualDocs_ImageName()
    }
}
*/
#endif
