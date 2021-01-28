//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import SwiftUI
#if !os(macOS)
import UIKit
#endif

public extension Shape {
    #if !os(macOS)
    func addSimpleStroke(color: UIColor, width: CGFloat) -> some View {
        self.stroke(Color(color), lineWidth: width)
    }
    #endif
}

public extension RoundedRectangle {
    #if !os(macOS)
    func addDashedStroke(color: UIColor, width: CGFloat) -> some View {
        self.strokeBorder(style: StrokeStyle(lineWidth: width, dash: [15])).foregroundColor(Color(color))
    }
    #endif
}

public extension View {

    func buildPreviews() -> some View {
        Group {
            self.previewDisplayName("Default")
            self.environment(\.colorScheme, .dark).previewDisplayName("Dark")
            self.previewDevice("iPhone 8").previewDisplayName("Default - iPhone8")
            self.previewDevice("iPhone 11 Pro").previewDisplayName("Default - iPhone11")
        }
    }

    // https://stackoverflow.com/questions/56517813/how-to-print-to-xcode-console-in-swiftui
    func SwiftUIDebugPrint(_ vars: Any..., function: String=#function) -> some View {
        let wereWasIt = function
        for some in vars { print("\(wereWasIt) : \(some)") }
        return EmptyView()
    }

    func SwiftUIDebugPrintOnReload(function: String=#function) -> some View {
        return self.SwiftUIDebugPrint("[\(self)] was reloaded", function: function)
    }

    // IfOnSimulator(view: Text("\(Date()) - Reloaded").eraseToAnyView())
    func IfOnSimulator(view: AnyView) -> some View {
        #if (arch(i386) || arch(x86_64))
        return view.eraseToAnyView()
        #else
        return EmptyView()
        #endif
    }

    // Perform { print("rendered") }
    // Perform(if: true) { print("rendered") }
    func Perform(_ block: () -> Void) -> some View {
        block()
        return EmptyView()
    }

    func Perform(if condition: Bool, _ block: () -> Void) -> some View {
        if condition {
            block()
        }
        return EmptyView()
    }

    // https://medium.com/better-programming/swiftui-tips-and-tricks-c7840d8eb01b
    func embedInNavigation() -> some View {
        NavigationView { self }
    }

    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

    // Wrap Views in AnyView or Groups When You Have Different Types
    // https://medium.com/better-programming/swiftui-tips-and-tricks-c7840d8eb01b
    func doIf_v1 <T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        Group {
            if condition {
                transform(self)
            } else {
                self
            }
        }
    }

    // https://matteo-puccinelli.medium.com/conditionally-apply-modifiers-in-swiftui-51c1cf7f61d1
    // How to conditionally apply modifiers in SwiftUI
    @ViewBuilder
    func ifCondition<TrueContent: View, FalseContent: View>(_ condition: Bool, then trueContent: (Self) -> TrueContent, else falseContent: (Self) -> FalseContent) -> some View {
        if condition {
            trueContent(self)
        } else {
            falseContent(self)
        }
    }

    // https://matteo-puccinelli.medium.com/conditionally-apply-modifiers-in-swiftui-51c1cf7f61d1
    // How to conditionally apply modifiers in SwiftUI
    @ViewBuilder
    func ifCondition<TrueContent: View>(_ condition: Bool, then trueContent: (Self) -> TrueContent) -> some View {
        if condition {
            trueContent(self)
        } else {
            self
        }
    }

    // Wrap Views in AnyView or Groups When You Have Different Types
    // https://medium.com/better-programming/swiftui-tips-and-tricks-c7840d8eb01b
    func doIf_v2 <T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            return transform(self).eraseToAnyView()
        } else {
            return self.eraseToAnyView()
        }
    }

    func userInteractionEnabled(_ value: Bool) -> some View {
        self.disabled(value)
    }

    func rotate(degrees: Double) -> some View {
        self.rotationEffect(.degrees(degrees))
    }

    func alpha(_ some: Double) -> some View {
        self.opacity(some)
    }

    func textColor(_ color: Color) -> some View {
        self.foregroundColor(color)
    }

    func addCorner(color: Color, lineWidth: CGFloat, padding: Bool) -> some View {
        self
            .doIf_v1(padding) { $0.padding(8) }
            .overlay(Capsule(style: .continuous).stroke(color, lineWidth: lineWidth).foregroundColor(Color.clear))
    }
}

#if !os(macOS)
public extension View {
    // Draw a corner, outside the View
    func addOuterCornerOverlaying(color: UIColor, radius: CGFloat = 3, width: CGFloat = 2, padding: Bool) -> some View {
        self
            .doIf_v1(padding) { $0.padding(8) }
            .overlay(RoundedRectangle(cornerRadius: radius).addSimpleStroke(color: color, width: width))
    }

    func debugWithSimpleStroke(color: UIColor = .red, width: CGFloat=3) -> some View {
        self.overlay(RoundedRectangle(cornerRadius: 0).addSimpleStroke(color: color, width: width))
    }
    
    func debugWithDashedStroke(color: UIColor = .red, width: CGFloat=3, dashed: Bool=true) -> some View {
        self.overlay(RoundedRectangle(cornerRadius: 0).addDashedStroke(color: color, width: width))
    }

    func debugComposed(color: UIColor = .red, width: CGFloat=3) -> some View {
        self.debugWithDashedStroke(color: color, width: width).padding(width).debugWithSimpleStroke(color: color, width: width)
    }
}
#endif