//
//  Created by Ricardo P Santos on 2020.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
//
import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFAppThemes
import RJSLibUFBaseVIP
import RJSLibUFDesignables

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct DesignLanguageVC_ViewControllerPreviews: PreviewProvider {
    static var previews: some View { RJS_ViewControllerRepresentable { VC.DesignLanguageVC() }.buildPreviews() }
}
#endif

extension VC {
    class DesignLanguageVC: GenericViewController {

        private lazy var scrollView: UIScrollView = { RJS_UIFactory.scrollView() }()
        private lazy var stackViewVLevel1: UIStackView = { RJS_UIFactory.stackView(axis: .vertical) }()

        override func loadView() {
            super.loadView()
            prepareLayout()
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            stackViewVLevel1.loadWithDesignLanguageReport()
        }

        override func prepareLayout() {
            view.backgroundColor = .white
        }
    }
}
