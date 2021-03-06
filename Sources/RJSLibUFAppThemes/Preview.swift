//
//  Created by Ricardo Santos on 06/03/2021.
//

#if !os(macOS)
import Foundation
import UIKit
import SwiftUI
//
import RJSLibUFBase

public struct RJSLibUFAppThemes {
    open class PreviewVC: UIViewController {
        public init() { super.init(nibName:nil, bundle:nil) }
        public required init?(coder: NSCoder) { super.init(coder: coder) }
        private lazy var scrollView: UIScrollView = { UIScrollView() }()
        private lazy var stackViewVLevel1: UIStackView = { UIStackView.verticalStackView() }()
        public override func loadView() {
            super.loadView()
            view.backgroundColor = UIColor.Pack3.background.color
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            stackViewVLevel1.loadWithDesignLanguageReport()
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

