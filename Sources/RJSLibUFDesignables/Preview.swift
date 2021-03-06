//
//  Created by Ricardo Santos on 06/03/2021.
//

import Foundation
import UIKit
import SwiftUI
//
import RJSLibUFBase
import RJSLibUFAppThemes

public extension RJSLibUFDesignables {
    static var allCasesUIKit: [UIView] { // alias for [MyEnum]
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
}

public extension RJSLibUFDesignables {
    open class PreviewVC: UIViewController {
        public init() { super.init(nibName:nil, bundle:nil) }
        public required init?(coder: NSCoder) { super.init(coder: coder) }
        private lazy var scrollView: UIScrollView = { RJS_UIFactory.scrollView() }()
        private lazy var stackViewVLevel1: UIStackView = { RJS_UIFactory.stackView(axis: .vertical) }()
        public override func loadView() {
            super.loadView()
            view.backgroundColor = UIColor.Pack3.background.color
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            RJSLibUFDesignables.allCasesUIKit.forEach { (some) in
                stackViewVLevel1.rjs.add(some)
                stackViewVLevel1.rjs.addSeparator(color: UIColor.Pack3.primary.color)
            }
        }
    }
    
    struct Preview: PreviewProvider {
        public static var previews: some View { RJS_ViewControllerRepresentable {
            RJSLibUFDesignables.PreviewVC()
        }.buildPreviews() }
    }
}
