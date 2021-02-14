//  RJSLibUFBase
//
//  Created by Ricardo Santos on 14/02/2021.
//

import Foundation
import SwiftUI

public extension RJSLib.Designables.SwiftUI {

   // https://medium.com/better-programming/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
    struct SlidingCircles: View {
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
   
   // https://medium.com/better-programming/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
    struct HorizontalSlidingBar: View {
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
   
   // https://medium.com/better-programming/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
    struct VerticalBar: View {
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
   
   // https://medium.com/better-programming/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
    struct CicleWithWaves: View {
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
