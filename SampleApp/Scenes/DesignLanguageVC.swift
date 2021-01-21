//
//  Created by Ricardo P Santos on 2020.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import UIKit
//
import RJSLibUFBase
import RJSLibUFStorage
import RJSLibUFNetworking
import RJSLibUFALayouts
import RJSLibUFAppThemes
import TinyConstraints

let screenWidth  = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

public extension UIView {
    
    func addAndSetup(scrollView: UIScrollView, stackViewV: UIStackView, hasTopBar: Bool) {
        self.addSubview(scrollView)
        scrollView.addSubview(stackViewV)
        stackViewV.edgeStackViewToSuperView()
        let topBarSize: CGFloat = hasTopBar ? 40 : 0
        let bottomBarSize: CGFloat = 0
        scrollView.trailingToSuperview()
        scrollView.leftToSuperview()
        scrollView.topToSuperview(offset: topBarSize, usingSafeArea: false)
        scrollView.height(screenHeight - topBarSize  - bottomBarSize)
    }
    
}

public extension UIStackView {
    
    func edgeStackViewToSuperView() {
        guard self.superview != nil else {
            return
        }
        self.edgesToSuperview()
        self.width(to: superview!) // NEEDS THIS!
    }
}

class DesignLanguageVC: GenericViewController {

    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    private lazy var scrollView: UIScrollView = { UIKitFactory.scrollView() }()
    private lazy var stackViewVLevel1: UIStackView = { UIKitFactory.stackView(axis: .vertical) }()
    
    override func loadView() {
        super.loadView()
        prepareLayout()
        self.view.addAndSetup(scrollView: scrollView, stackViewV: stackViewVLevel1, hasTopBar: false)
        stackViewVLevel1.buildAndAddReport()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func prepareLayout() {
        self.view.backgroundColor = .white
    }
}
