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

#if USE_INCLUDE_TINYCONSTRAINTS
import TinyConstraints

class TestingDesignLanguageVC: GenericViewController {

    private lazy var scrollView: UIScrollView = { UIKitFactory.scrollView() }()
    private lazy var stackViewVLevel1: UIStackView = { UIKitFactory.stackView(axis: .vertical) }()
    
    override func loadView() {
        super.loadView()
        prepareLayout()
        view.addAndSetup(scrollView: scrollView, stackViewV: stackViewVLevel1, hasTopBar: false)
        stackViewVLevel1.loadWithDesignLanguageReport()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func prepareLayout() {
        view.backgroundColor = .white
    }
}
#else
class TestingDesignLanguageVC: GenericViewController {
    override func loadView() {
        super.loadView()
    }
}
#endif
