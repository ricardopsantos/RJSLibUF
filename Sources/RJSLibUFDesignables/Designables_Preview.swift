//
//  Created by Ricardo Santos on 06/03/2021.
//
#if !os(macOS)
import Foundation
import UIKit
import SwiftUI
//
import RJSLibUFBase
import RJSLibUFAppThemes

public extension RJSLibUFDesignables_Preview {
    
    @State private static var textState = ""
    
    static var allCasesUIKit: [UIView] {
        let image = UIImage(color: RJS_ColorPack3.primary.color, size: CGSize(width: 30, height: 30))!
        return [
            RJS_Designables_UIKit.SearchBar(),
            RJS_Designables_UIKit.SearchTextField(),
            RJS_Designables_UIKit.ButtonPrimary(title: "ButtonPrimary"),
            RJS_Designables_UIKit.ButtonSecondary(title: "ButtonSecondary"),
            RJS_Designables_UIKit.ButtonSecondaryDestructive(title: "ButtonSecondaryDestructive"),
            RJS_Designables_UIKit.ButtonAccept(title: "ButtonAccept"),
            RJS_Designables_UIKit.ButtonReject(title: "ButtonReject"),
            RJS_Designables_UIKit.ButtonRemind(title: "ButtonRemind"),
            RJS_Designables_UIKit.ButtonInnGage(title: "ButtonInnGage"),
            RJS_Designables_UIKit.ButtonText(title: "ButtonText",
                                             color: RJS_ColorPack3.primary.color),
            RJS_Designables_UIKit.ButtonIcon(image: image,
                                             color: RJS_ColorPack3.primary.color),
            RJS_Designables_UIKit.ButtonIconAndText(title: "ButtonIconAndText",
                                                    image: image,
                                                    color: RJS_ColorPack3.primary.color)
        ]
     }
        
    static func allCasesSwiftUI(_ type: String) -> [AnyView] {
        func allCasesFilter(allCases: [Any], type: String) -> [Any] {
            // Im not proud of this...
            return allCases.filter { "\($0)".contains("\(type)") }
        }
        return allCasesFilter(allCases: allCasesSwiftUI, type: type).map { ($0 as! AnyView) }
    }
    
    static var allCasesSwiftUI: [AnyView] {
        return [
            RJS_Designables_SwiftUI.ViewWithAnyViews([Text("ViewWithAnyViews").erase()]).erase(),
            RJS_Designables_SwiftUI.ListItem(title: "ListItem.title1",
                                             value: "ListItem.value1").erase(),
            RJS_Designables_SwiftUI.ListItem(title: "ListItem.title2",
                                             value: "ListItem.value2",
                                             imageName: "paperplane.fill",
                                             imageColor1: Color.red,
                                             imageColor2: Color.blue).erase(),
            RJS_Designables_SwiftUI.ListItem(title: "ListItem title 3",
                                             value: "ListItem value3",
                                             imageName: "paperplane.fill").erase(),
            RJS_Designables_SwiftUI.TitleAndValue(title: "TitleAndValue.title", value: "TitleAndValue.value").erase(),
            RJS_Designables_SwiftUI.CustomButton(title: "title").erase(),
            RJS_Designables_SwiftUI.ErrorView1(message: "message").erase(),
            RJS_Designables_SwiftUI.FloatingTextField(title: "First Name",
                                                      text: $textState).erase()
        ]
     }
}

public struct RJSLibUFDesignables_Preview {
    open class PreviewVC: UIViewController {
        public init() { super.init(nibName: nil, bundle: nil) }
        public required init?(coder: NSCoder) { super.init(coder: coder) }
        private lazy var scrollView: UIScrollView = { RJS_UIFactory.scrollView() }()
        private lazy var stackViewVLevel1: UIStackView = { UIStackView.defaultVerticalStackView() }()
        public override func loadView() {
            super.loadView()
            view.backgroundColor = RJS_ColorPack3.background.color
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            RJSLibUFDesignables_Preview.allCasesUIKit.forEach { (some) in
                stackViewVLevel1.rjs.add(uiview: some)
                stackViewVLevel1.rjs.addSeparator(color: RJS_ColorPack3.primary.color)
            }
            RJSLibUFDesignables_Preview.allCasesSwiftUI.forEach { (some) in
                stackViewVLevel1.rjs.add(any: some)
                stackViewVLevel1.rjs.addSeparator(color: RJS_ColorPack3.primary.color)
            }
        }
    }
    
    #if canImport(SwiftUI) && DEBUG
    struct Preview: PreviewProvider {
        static var previews: some View { RJS_ViewControllerRepresentable {
            PreviewVC()
        }.buildPreviews() }
    }
    #endif
}
#endif
