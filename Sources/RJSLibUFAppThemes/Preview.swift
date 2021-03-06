//
//  Created by Ricardo Santos on 06/03/2021.
//

import Foundation
import UIKit
import SwiftUI
//
import RJSLibUFBase

public struct RJSLibUFAppThemes {
    open class PreviewVC: UIViewController {
        public init() { super.init(nibName:nil, bundle:nil) }
        public required init?(coder: NSCoder) { super.init(coder: coder) }
        private lazy var scrollView: UIScrollView = { RJS_UIFactory.scrollView() }()
        private lazy var stackViewVLevel1: UIStackView = { RJS_UIFactory.stackView(axis: .vertical) }()
        public override func loadView() {
            super.loadView()
            view.backgroundColor = UIColor.Pack3.background.color
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            stackViewVLevel1.loadWithDesignLanguageReport()
        }
    }
    
    struct Preview: PreviewProvider {
        static var previews: some View { RJS_ViewControllerRepresentable {
            RJSLibUFAppThemes.PreviewVC()
        }.buildPreviews() }
    }
}


