//  RJSLibUFBase
//
//  Created by Ricardo Santos on 14/02/2021.
//

import UIKit
import Foundation
import SwiftUI
import Combine

private let animationPack1 = RJS_Designables_SwiftUI.LoadingAnimations.Pack1.self
private let animationPack2 = RJS_Designables_SwiftUI.LoadingAnimations.Pack2.self

public extension RJSLib.Designables.SwiftUI {
        
    struct LoadingAnimations {
        private init() { }
        
        //
        // https://medium.com/better-programming/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
        //
        
        public struct Pack1 {
            private init() { }
            public struct SlidingCircles: View {
                @State private var shouldAnimate = false
                public var body: some View {
                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                            .animation(Animation.easeInOut(duration: 0.5).repeatForever())
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                            .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                            .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
                    }
                    .onAppear {
                        self.shouldAnimate = true
                    }
                }
            }
            
            public struct HorizontalSlidingBar: View {
                @State private var shouldAnimate = false
                @State var leftOffset: CGFloat = -100
                @State var rightOffset: CGFloat = 100
                 public var body: some View {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: 80, height: 20)
                        .offset(x: shouldAnimate ? rightOffset : leftOffset)
                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                        .onAppear {
                            self.shouldAnimate = true
                        }
                }
            }
            
            public struct VerticalBar: View {
                @State private var shouldAnimate = false
                 public var body: some View {
                    HStack(alignment: .center, spacing: shouldAnimate ? 15 : 5) {
                        Capsule(style: .continuous)
                            .fill(Color.blue)
                            .frame(width: 10, height: 50)
                        Capsule(style: .continuous)
                            .fill(Color.blue)
                            .frame(width: 10, height: 30)
                        Capsule(style: .continuous)
                            .fill(Color.blue)
                            .frame(width: 10, height: 50)
                        Capsule(style: .continuous)
                            .fill(Color.blue)
                            .frame(width: 10, height: 30)
                        Capsule(style: .continuous)
                            .fill(Color.blue)
                            .frame(width: 10, height: 50)
                    }
                    .frame(width: shouldAnimate ? 150 : 100)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                    .onAppear {
                        self.shouldAnimate = true
                    }
                }
            }
            
            public struct CicleWithWaves: View {
                @State private var shouldAnimate = false
                 public var body: some View {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 30, height: 30)
                        .overlay(
                            ZStack {
                                Circle()
                                    .stroke(Color.blue, lineWidth: 100)
                                    .scaleEffect(shouldAnimate ? 1 : 0)
                                Circle()
                                    .stroke(Color.blue, lineWidth: 100)
                                    .scaleEffect(shouldAnimate ? 1.5 : 0)
                                Circle()
                                    .stroke(Color.blue, lineWidth: 100)
                                    .scaleEffect(shouldAnimate ? 2 : 0)
                            }
                            .opacity(shouldAnimate ? 0.0 : 0.2)
                            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false))
                    )
                    .onAppear {
                        self.shouldAnimate = true
                    }
                }
            }
        }
        
        //
        // https://medium.com/better-programming/activity-indicators-in-swiftui-17b66e6c0137
        //
        
        public struct Pack2 {
            public struct ActivityIndicator_V1: UIViewRepresentable {
                public var isAnimating: Bool
                public init(isAnimating: Bool) {
                    self.isAnimating = isAnimating
                }
                public func makeUIView(context: Context) -> UIActivityIndicatorView {
                    return UIActivityIndicatorView(style: .large)
                }
                public func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
                    if isAnimating {
                        activityIndicator.startAnimating()
                    } else {
                        activityIndicator.stopAnimating()
                    }
                }
            }
            
            public struct ActivityIndicator_V2: View {
                @State var isDoingAnimation: Bool = false
                @Binding var isAnimating: Bool
                public init(isAnimating: Binding<Bool>) {
                    // https://stackoverflow.com/questions/56973959/swiftui-how-to-implement-a-custom-init-with-binding-variables
                    self._isAnimating = isAnimating // beta 4
                }
                public var body: some View {
                    GeometryReader { (geometry: GeometryProxy) in
                        ForEach(0..<5) { index in
                            Group {
                                Circle()
                                .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                                .scaleEffect(!self.isDoingAnimation ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
                                .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .rotationEffect(!self.isDoingAnimation ? .degrees(0) : .degrees(360))
                            .animation(Animation
                            .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                            .repeatForever(autoreverses: false))
                        }
                    }
                    .frame(width: 75, height: 75)
                    .foregroundColor(Color.secondary)
                    .aspectRatio(1, contentMode: .fit)
                    .onAppear { self.isDoingAnimation = true }
                    .opacity(isAnimating ? 1 : 0)
                }
            }

            public struct ActivityIndicator_V3<Content>: View where Content: View {
                @Binding public var isAnimating: Bool
                @Binding public var message: String
                var content: (() -> Content)?
                public init(isAnimating: Binding<Bool>, message: Binding<String>, content: @escaping () -> Content) {
                    // https://stackoverflow.com/questions/56973959/swiftui-how-to-implement-a-custom-init-with-binding-variables
                    self._isAnimating = isAnimating // beta 4
                    self._message = message
                    self.content = content
                }
                public var body: some View {
                    GeometryReader { geometry in
                        ZStack(alignment: .center) {
                            self.content?().disabled(self.isAnimating).blur(radius: self.isAnimating ? 3 : 0)
                            VStack {
                                Text(self.message)
                                ActivityIndicator_V2(isAnimating: .constant(true)).frame(width: 50, height: 50)
                            }
                            .frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                            .background(Color.secondary.colorInvert())
                            .foregroundColor(Color.primary)
                            .cornerRadius(20)
                            .opacity(self.isAnimating ? 1 : 0)
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

struct Previews_LoadingAnimations {
    struct Preview1: PreviewProvider {
        public static var previews: some View {
            ZStack {
                RJSLib.Designables.TestViews.SwiftUI().disabled(true).blur(radius: true ? 3 : 0)
                RJS_Designables_SwiftUI.LoadingAnimations.Pack1.SlidingCircles()
            }
        }
    }
    
    struct Preview2: PreviewProvider {
        public static var previews: some View {
            ZStack {
                RJSLib.Designables.TestViews.SwiftUI().disabled(true).blur(radius: true ? 3 : 0)
                animationPack1.CicleWithWaves()
            }
        }
    }

    struct Preview3: PreviewProvider {
        public static var previews: some View {
            ZStack {
                RJSLib.Designables.TestViews.SwiftUI().disabled(true).blur(radius: true ? 3 : 0)
                animationPack1.HorizontalSlidingBar()
            }
        }
    }

    struct Preview4: PreviewProvider {
        public static var previews: some View {
            ZStack {
                RJSLib.Designables.TestViews.SwiftUI().disabled(true).blur(radius: true ? 3 : 0)
                animationPack1.VerticalBar()
            }
        }
    }

    struct Preview5: PreviewProvider {
        public static var previews: some View {
            ZStack {
                RJSLib.Designables.TestViews.SwiftUI().disabled(true).blur(radius: true ? 3 : 0)
                animationPack2.ActivityIndicator_V1(isAnimating: true)
            }
        }
    }

    struct Preview6: PreviewProvider {
        public static var previews: some View {
            ZStack {
                RJSLib.Designables.TestViews.SwiftUI().disabled(true).blur(radius: true ? 3 : 0)
                animationPack2.ActivityIndicator_V2(isAnimating: .constant(true)).frame(width: 75, height: 75)
            }
        }
    }

    struct Preview7: PreviewProvider {
        public static var previews: some View {
            animationPack2.ActivityIndicator_V3(isAnimating: .constant(true),
                                                message: .constant("Loading"),
                                                content: {
                                                    RJSLib.Designables.TestViews.SwiftUI()
            })
        }
    }

}
