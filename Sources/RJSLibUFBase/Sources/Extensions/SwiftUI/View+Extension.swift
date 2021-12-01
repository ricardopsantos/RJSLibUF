//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//
#if !os(macOS)
import Foundation
import SwiftUI

public extension SwiftUI.Shape {
    func addSimpleStroke(color: UIColor, width: CGFloat) -> some View {
        self.stroke(Color(color), lineWidth: width)
    }
}

public extension RoundedRectangle {
    func addDashedStroke(color: UIColor, width: CGFloat) -> some View {
        self.strokeBorder(style: StrokeStyle(lineWidth: width, dash: [15])).foregroundColor(Color(color))
    }
}

//
// MARK: - Previews
//

public extension SwiftUI.View {

    var buildPreviewPhone11: some SwiftUI.View {
        previewDevice("iPhone 8").previewDisplayName("Default - iPhone11")
    }
    
    var buildPreviewPhone8: some SwiftUI.View {
        previewDevice("iPhone 8").previewDisplayName("Default - iPhone8")
    }
    
    var buildPreviewDark: some SwiftUI.View {
        environment(\.colorScheme, .dark).previewDisplayName("Dark")
    }
    
    var buildPreviewExtraLarge: some SwiftUI.View {
        environment(\.sizeCategory, .extraLarge).previewDisplayName("ExtraLarge")
    }
    
    func buildPreviews(full: Bool = false) -> some SwiftUI.View {
        Group {
            if full {
                previewDisplayName("Default")
                environment(\.sizeCategory, .extraLarge).previewDisplayName("ExtraLarge")
                environment(\.colorScheme, .dark).previewDisplayName("Dark")
                previewDevice("iPhone 8").previewDisplayName("Default - iPhone8")
                previewDevice("iPhone 11 Pro").previewDisplayName("Default - iPhone11")
            } else {
                previewDisplayName("Default")
            }
        }
    }

}

public extension SwiftUI.View {

    // https://stackoverflow.com/questions/56517813/how-to-print-to-xcode-console-in-swiftui
    func SwiftUIDebugPrint(_ vars: Any..., function: String=#function) -> some View {
        let wereWasIt = function
        for some in vars { RJS_Logs.debug("\(wereWasIt) : \(some)", tag: .rjsLib) }
        //return EmptyView()
        return self
    }

    func SwiftUIDebugPrintOnReload(function: String=#function) -> some View {
        return self.SwiftUIDebugPrint("[\(self)] was reloaded", function: function)
    }

    // https://medium.com/better-programming/swiftui-tips-and-tricks-c7840d8eb01b
    func embedInNavigation() -> some View {
        NavigationView { self }
    }

    var erased: AnyView {
        AnyView(self)
    }
    
    var erasedToAnyView: AnyView {
        AnyView(self)
    }
    
    func userInteractionEnabled(_ value: Bool) -> some View {
        disabled(value)
    }

    func rotate(degrees: Double) -> some View {
        rotationEffect(.degrees(degrees))
    }

    func alpha(_ some: Double) -> some View {
        opacity(some)
    }

    func textColor(_ color: Color) -> some View {
        foregroundColor(color)
    }

    func addCorner(color: Color, lineWidth: CGFloat, padding: Bool) -> some View {
        self
            .doIf(padding) { $0.padding(8) }
            .overlay(Capsule(style: .continuous).stroke(color, lineWidth: lineWidth).foregroundColor(Color.clear))
    }
}

public extension View {
    // Draw a corner, outside the View
    func addOuterCornerOverlaying(color: UIColor, radius: CGFloat = 3, width: CGFloat = 2, padding: Bool) -> some View {
        self
            .doIf(padding) { $0.padding(8) }
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

//
// MARK: - Conditionals
//
public extension View {
        
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
    
    func PerformIfSimulator(_ block: () -> Void) -> some View {
        return Perform(if: RJS_Utils.onSimulator, block)
    }
    
    // IfOnSimulator(view: Text("\(Date()) - Reloaded").eraseToAnyView())
    func ifOnSimulator<TrueContent: View>(then transform: (Self) -> TrueContent) -> some View {
        RJS_Utils.onSimulator ? transform(self).erasedToAnyView : self.erasedToAnyView
    }
    
    // https://matteo-puccinelli.medium.com/conditionally-apply-modifiers-in-swiftui-51c1cf7f61d1
    // How to conditionally apply modifiers in SwiftUI
    @ViewBuilder
    func ifElseCondition<TrueContent: View, FalseContent: View>(_ condition: Bool,
                                                                then trueContent: (Self) -> TrueContent,
                                                                else falseContent: (Self) -> FalseContent) -> some View {
        if condition { trueContent(self)
        } else { falseContent(self) }
    }

    // https://matteo-puccinelli.medium.com/conditionally-apply-modifiers-in-swiftui-51c1cf7f61d1
    // How to conditionally apply modifiers in SwiftUI
    @ViewBuilder
    func ifCondition<TrueContent: View>(_ condition: Bool,
                                        then trueContent: (Self) -> TrueContent) -> some View {
        self.ifElseCondition(condition, then: trueContent, else: { _ in self })
    }
    
    // https://medium.com/better-programming/swiftui-tips-and-tricks-c7840d8eb01b
    func doIf<Content: View>(_ condition: Bool,
                             transform: (Self) -> Content) -> some View {
        // Booth versions bellow work
        let method = Int.random(in: 0...3)
        if method == 1 {
            return Group { if condition { transform(self) } else { self } }.erased
        } else if method == 2 {
            return condition ? transform(self).erased : erased
        } else {
            return ifCondition(condition, then: transform).erased
        }
    }
}

public extension RJSLibUFBase_Preview {
    struct ConditionalViews: View {
        @State private var condition = false
        public init() { }
        public var body: some View {
            VStack {
                Button("Tap me") { condition.toggle() }
                Spacer()
                VStack {
                    Text("if")
                    Image(systemName: "heart")
                        .doIf(condition) { some in some.rotate(degrees: 90) }
                    Image(systemName: "heart")
                        .doIf(condition, transform: { $0.rotate(degrees: -90) })
                }
                VStack {
                    Text("ifOnSimulator")
                    Image(systemName: "star")
                        .ifOnSimulator { some in some.foregroundColor(Color(.red)) }
                    Image(systemName: "star")
                        .ifOnSimulator { $0.foregroundColor(Color(.red)) }
                }
                VStack {
                    Text("ifCondition")
                    Image(systemName: "star")
                        .ifCondition(condition) { some in some.foregroundColor(Color(.red)) }
                    Image(systemName: "star")
                        .ifCondition(condition) { $0.foregroundColor(Color(.red)) }
                }
                VStack {
                    Text("ifElseCondition")
                    Image(systemName: "circle")
                        .ifElseCondition(condition) { some in some.foregroundColor(Color(.blue)) } else: { some in some.foregroundColor(Color(.green)) }
                    Image(systemName: "circle")
                        .ifElseCondition(condition) { $0.foregroundColor(Color(.blue)) } else: { $0.foregroundColor(Color(.green)) }
                }
                VStack {
                    PerformIfSimulator { RJS_Logs.debug("On Simulator", tag: .rjsLib) }
                    Perform { RJS_Logs.info("perfomed_1", tag: .rjsLib) }
                    Perform(if: condition) {
                        RJS_Logs.info("perfomed_2", tag: .rjsLib)
                    }
                }
                Spacer()
            }
        }
    }
}

#if canImport(SwiftUI) && DEBUG
struct ViewWithAnyViews: PreviewProvider {
    public static var previews: some View {
        RJSLibUFBase_Preview.ConditionalViews()
    }
}
#endif
#endif
