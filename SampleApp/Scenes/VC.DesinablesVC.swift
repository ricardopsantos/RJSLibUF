//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
import LocalAuthentication
//
import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFAppThemes
import RJSLibUFBaseVIP

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct DesinablesVC_ViewControllerPreviews: PreviewProvider {
    static var previews: some View { RJS_ViewControllerRepresentable { VC.DesinablesVC() }.buildPreviews() }
}
#endif

extension VC {
    class DesinablesVC: GenericViewController {
        
        private lazy var scrollView: UIScrollView = { RJS_UIFactory.scrollView() }()
        private lazy var stackViewVLevel1: UIStackView = { RJS_UIFactory.stackView(axis: .vertical) }()

        private lazy var searchBar: RJS_Designables_UIKit.SearchBar = {
            RJS_Designables_UIKit.SearchBar()
        }()
        
        private lazy var buttonPrimary: RJS_Designables_UIKit.ButtonPrimary = {
            RJS_Designables_UIKit.ButtonPrimary(text: "ButtonPrimary",
                                                           font: font,
                                                           fontColor: fontColor,
                                                           buttonColor: primary)
        }()
        
        private lazy var buttonSecondary1: RJS_Designables_UIKit.ButtonSecondary = {
            RJS_Designables_UIKit.ButtonSecondary(text: "buttonSecondary1",
                                                             font: font,
                                                             color: primary)
        }()
        
        private lazy var buttonSecondary2: RJS_Designables_UIKit.ButtonSecondary = {
            RJS_Designables_UIKit.ButtonSecondary(text: "buttonSecondary2",
                                                             font: font,
                                                             color: RJS_ColorPack3.danger.color)
        }()
        
        private lazy var buttonText: RJS_Designables_UIKit.ButtonText = {
            RJS_Designables_UIKit.ButtonText(text: "ButtonText",
                                                        font: font,
                                                        color: primary)
        }()
        
        private lazy var buttonIcon: RJS_Designables_UIKit.ButtonIcon = {
            RJS_Designables_UIKit.ButtonIcon(image: image!, color: RJS_ColorPack3.danger.color)
        }()
        
        private lazy var buttonActiontText: RJS_Designables_UIKit.ButtonIconAndText = {
            RJS_Designables_UIKit.ButtonIconAndText(text: "ButtonIconAndText",
                                                               image: image!,
                                                               font: font,
                                                               color: primary)
        }()
        
        override func loadView() {
            super.loadView()
            view.backgroundColor = .white
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            
            let views = [searchBar,
                         buttonPrimary,
                         buttonSecondary1,
                         buttonSecondary2,
                         buttonIcon,
                         buttonActiontText,
                         buttonText]
            
            views.forEach { (some) in
                stackViewVLevel1.rjs.add(some)
                stackViewVLevel1.rjs.addSeparator()
            }
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
    }
}
