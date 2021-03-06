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
struct TestingMiscVC_PreviewProvider: PreviewProvider {
    static var previews: some View { RJS_ViewControllerRepresentable { VC.TestingMiscVC() }.buildPreviews() }
}
#endif

extension VC {
    class TestingMiscVC: GenericViewController {

        private lazy var scrollView: UIScrollView = { RJS_UIFactory.scrollView() }()
        private lazy var stackViewVLevel1: UIStackView = { RJS_UIFactory.stackView(axis: .vertical) }()
        
        private lazy var label: UILabel = {
            let some = UILabel()
            some.numberOfLines = 0
            return some
        }()
        
        private lazy var btnDynamicMemberLookup: UIButton = {
            let some = RJS_UIFactory.button(title: "@dynamicMemberLookup", style: .primary)
            some.rjsCombine.touchUpInsidePublisher.sink { [weak self] _ in
                let country = DynamicMemberLookupCountry()
                self?.display(country.name, override: true)
                self?.display(country.location, override: false)
                self?.display(country.xxx, override: false)
            }.store(in: cancelBag)
            return some
        }()
        
        override func loadView() {
            super.loadView()
            view.backgroundColor = RJS_ColorPack3.background.color
            view.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
    
            stackViewVLevel1.rjs.add(label)
            stackViewVLevel1.rjs.add(btnDynamicMemberLookup)

            _ = view.rjs.allSubviews.filter { $0.isKind(of: UIButton.self) }.map { $0.layouts.height(44) }
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        private var someProp: Bool = false {
            didSet { btnDynamicMemberLookup.alpha = someProp ? 0.5 : 1 }
        }

    }
}

fileprivate extension VC.TestingMiscVC {
    private func display(_ message: String, override: Bool) {
        if override {
            label.textAnimated = "\(message)\n"
        } else {
            label.textAnimated = "\(label.text ?? "")\(message)\n"
        }
    }
}
