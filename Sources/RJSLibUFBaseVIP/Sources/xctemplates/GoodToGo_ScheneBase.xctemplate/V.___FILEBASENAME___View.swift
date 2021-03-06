//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation
//
import RJSLibUFBase

//
// MARK: - Preview
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ___VARIABLE_sceneName___ViewPreviews: PreviewProvider {
    static var previews: some View {
        RJS_ViewRepresentable { V.___VARIABLE_sceneName___View() }.buildPreviews()
    }
}

@available(*, deprecated)
struct ___VARIABLE_sceneName___UIViewRepresentable: UIViewRepresentable {
    func updateUIView(_ uiView: V.___VARIABLE_sceneName___View, context: Context) { }
    func makeUIView(context: Context) -> V.___VARIABLE_sceneName___View {
        return V.___VARIABLE_sceneName___View()
    }
}

@available(*, deprecated)
struct ___VARIABLE_sceneName___Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ___VARIABLE_sceneName___UIViewRepresentable().buildPreviews()
    }
}
 
#endif

//
// MARK: - View
//

extension V {
    public class ___VARIABLE_sceneName___View: RJS_BaseGenericViewVIP {

        deinit {
            NotificationCenter.default.removeObserver(self)
        }

        // MARK: - UI Elements (Private and lazy by default)

        private lazy var scrollView: UIScrollView = {
            return UIScrollView()
        }()

        private lazy var stackViewVLevel1: UIStackView = {
            let some = UIStackView()
            some.axis = .vertical
            return some
        }()

        private lazy var lblTitle: UILabel = {
            return UILabel()
        }()

        private lazy var btnSample1: UIButton = {
            let some = UIButton(type: .custom)
            some.rjs.setTitleForAllStates("UIButton")
            return some
        }()

        private lazy var btnSample2: UIButton = {
            return UIButton()
        }()

        // MARK: - Mandatory

        // This function is called automatically by super BaseGenericViewVIP
        // There are 3 functions specialised according to what we are doing. Please use them accordingly
        // Function 1/3 : JUST to add stuff to the view....
        public override func prepareLayoutCreateHierarchy() {
            addSubview(scrollView)
            scrollView.addSubview(stackViewVLevel1)
            stackViewVLevel1.rjs.add(uiview: lblTitle)
            stackViewVLevel1.rjs.add(uiview: btnSample1)
        }

        // This function is called automatically by super BaseGenericViewVIP
        // There are 3 functions specialised according to what we are doing. Please use them accordingly
        // Function 2/3 : JUST to setup layout rules zone....
        public override func prepareLayoutBySettingAutoLayoutsRules() {
            self.layouts.addAndSetup(scrollView: scrollView, with: stackViewVLevel1, usingSafeArea: true)
            self.allSubviews.filter { $0 .isKind(of: UIButton.self) }.forEach { (some) in
                some.layouts.height(40)
            }
        }

        // This function is called automatically by super BaseGenericViewVIP
        // There are 3 functions specialised according to what we are doing. Please use them accordingly
        // Function 3/3 : Stuff that is not included in [prepareLayoutCreateHierarchy] and [prepareLayoutBySettingAutoLayoutsRules]
        public override func prepareLayoutByFinishingPrepareLayout() {
            // What should this function be used for? Extra stuff zone (not included in [prepareLayoutCreateHierarchy]
            // and [prepareLayoutBySettingAutoLayoutsRules]
            lblTitle.textAlignment = .center
            lblTitle.numberOfLines = 0
        }

        public override func setupColorsAndStyles() {
            backgroundColor = .lightGray
        }

        // This function is called automatically by super BaseGenericView
        public override func setupViewUIRx() {

        }

        // MARK: - Custom Getter/Setters

        // We can set the view data by : 1 - Rx                                     ---> var rxTableItems = BehaviorRelay <---
        // We can set the view data by : 2 - Custom Setters / Computed Vars         ---> var subTitle: String <---
        // We can set the view data by : 3 - Passing the view model inside the view ---> func setupWith(viewModel: ... <---

        public var subTitle: String {
            get { return  lblTitle.text ?? "" }
            set(newValue) {
                lblTitle.textAnimated = newValue
            }
        }

        func setupWith(someStuff viewModel: VM.___VARIABLE_sceneName___.Something.ViewModel) {
            subTitle = viewModel.subTitle
        }

        func setupWith(screenInitialState viewModel: VM.___VARIABLE_sceneName___.ScreenInitialState.ViewModel) {
            subTitle = viewModel.subTitle
            screenLayout = viewModel.screenLayout
        }

        var screenLayout: ___VARIABLE_sceneName___View.ScreenLayout = .layoutA {
            didSet {
                // show or hide stuff
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension V.___VARIABLE_sceneName___View: UITableViewDelegate {

}

// MARK: - Events capture

extension V.___VARIABLE_sceneName___View {
    var rxBtnTap: RJSLib.UIControlPublisher<UIControl> { return btnSample1.rjsCombine.publisher(for: .touchUpInside) }
}
