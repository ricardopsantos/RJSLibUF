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

class TestingsDesinablesVC: GenericViewController {

    private var cancelBag = CancelBag()
    
    private lazy var scrollView: UIScrollView = { RJS_UIFactory.scrollView() }()
    private lazy var stackViewVLevel1: UIStackView = { RJS_UIFactory.stackView(axis: .vertical) }()

    let image = UIImage(named: "image.sample.1")
    let font = RJS_Fonts.Styles.paragraphMedium.rawValue
    let fontColor = RJS_ColorPack3.onPrimary.color
    let primary = RJS_ColorPack3.primary.color

    private lazy var searchBar: RJS_Designables_UIKit.SearchBar = {
        let some = RJS_Designables_UIKit.SearchBar()
        return some
    }()
    
    private lazy var buttonPrimary: RJS_Designables_UIKit.ButtonPrimary = {
        let some = RJS_Designables_UIKit.ButtonPrimary(text: "ButtonPrimary",
                                                       font: font,
                                                       fontColor: fontColor,
                                                       buttonColor: primary)
        some.publisher(for: .touchUpInside).sink { [weak self] _ in }.store(in: cancelBag)
        return some
    }()
    
    private lazy var buttonSecondary1: RJS_Designables_UIKit.ButtonSecondary = {
        let some = RJS_Designables_UIKit.ButtonSecondary(text: "buttonSecondary1",
                                                         font: font,
                                                         color: primary)
        some.publisher(for: .touchUpInside).sink { [weak self] _ in }.store(in: cancelBag)
        return some
    }()
    
    private lazy var buttonSecondary2: RJS_Designables_UIKit.ButtonSecondary = {
        let some = RJS_Designables_UIKit.ButtonSecondary(text: "buttonSecondary2",
                                                         font: font,
                                                         color: RJS_ColorPack3.danger.color)
        some.publisher(for: .touchUpInside).sink { [weak self] _ in }.store(in: cancelBag)
        return some
    }()
    
    private lazy var buttonText: RJS_Designables_UIKit.ButtonText = {
        let some = RJS_Designables_UIKit.ButtonText(text: "ButtonText",
                                                    font: font,
                                                    color: primary)
        some.publisher(for: .touchUpInside).sink { [weak self] _ in }.store(in: cancelBag)
        return some
    }()
    
    private lazy var buttonIcon: RJS_Designables_UIKit.ButtonIcon = {
        let some = RJS_Designables_UIKit.ButtonIcon(image: image!, color: RJS_ColorPack3.danger.color)
        some.publisher(for: .touchUpInside).sink { [weak self] _ in }.store(in: cancelBag)
        return some
    }()
    
    private lazy var buttonActiontText: RJS_Designables_UIKit.ButtonIconAndText = {
        let some = RJS_Designables_UIKit.ButtonIconAndText(text: "ButtonIconAndText",
                                                           image: image!,
                                                           font: font,
                                                           color: primary)
        some.publisher(for: .touchUpInside).sink { [weak self] _ in }.store(in: cancelBag)
        return some
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
