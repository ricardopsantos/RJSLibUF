//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
//
import RJSLibUFBase

// MARK: - Preview

struct ___VARIABLE_sceneName___ViewController_UIViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: VC.___VARIABLE_sceneName___ViewController, context: Context) { }
    func makeUIViewController(context: Context) -> VC.___VARIABLE_sceneName___ViewController {
        let vc = VC.___VARIABLE_sceneName___ViewController()
        vc.interactor?.requestScreenInitialState()
        return vc
    }
}

struct ___VARIABLE_sceneName___ViewController_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        return ___VARIABLE_sceneName___ViewController_UIViewControllerRepresentable()
    }
}

// MARK: - ViewController

extension VC {

    public class ___VARIABLE_sceneName___ViewController: RJS_BaseGenericViewControllerVIP<V.___VARIABLE_sceneName___View> {

        deinit {
            NotificationCenter.default.removeObserver(self)
        }

        fileprivate var interactor: ___VARIABLE_sceneName___BusinessLogicProtocol?
        var router: (___VARIABLE_sceneName___RoutingLogicProtocol &
            ___VARIABLE_sceneName___DataPassingProtocol &
            ___VARIABLE_sceneName___RoutingLogicProtocol)?

        //
        // MARK: View lifecycle
        //

        public override func loadView() {
            super.loadView()
            genericView.accessibilityIdentifier = self.genericAccessibilityIdentifier
        }

        public override func viewDidLoad() {
            super.viewDidLoad()
        }

        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if firstAppearance {
                interactor?.requestScreenInitialState()
            }
        }

        public override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        }

        //
        // MARK: Dark Mode
        //

        public override func setupColorsAndStyles() {
            //super.setupColorsAndStyles()
            // Setup UI on dark mode (if needed)
        }

        //
        // MARK: Mandatory methods
        //

        public override func setup() {
            // This function is called automatically by super BaseGenericView
            let viewController = self
            let interactor = I.___VARIABLE_sceneName___Interactor()
            let presenter  = P.___VARIABLE_sceneName___Presenter()
            let router     = R.___VARIABLE_sceneName___Router()
            viewController.interactor = interactor
            viewController.router    = router
            interactor.presenter     = presenter
            presenter.viewController = viewController
            router.viewController    = viewController
            router.dataStore         = interactor
        }

        // This function is called automatically by super BaseGenericView
        public override func prepareLayoutByFinishingPrepareLayout() {
            // What should this function be used for? Extra stuff zone (not included in [prepareLayoutCreateHierarchy]
            // and [prepareLayoutBySettingAutoLayoutsRules]
            // ...
            // table.separatorColor = .clear
            // label.textAlignment = .center
            // ...
        }

        // This function is called automatically by super BaseGenericView
        public override func prepareLayoutBySettingAutoLayoutsRules() {
            // What should this function be used for? Setup layout rules zone....
            // ...
            // someView.widthToSuperview()
            // someView.bottomToSuperview()
            // ...
            //
        }

        // This function is called automatically by super BaseGenericView
        public override func prepareLayoutCreateHierarchy() {
            // What should this function be used for? Add stuff to the view zone....
            // ...
            // addSubview(scrollView)
            // scrollView.addSubview(stackViewVLevel1)
            // ...
            //
        }

        // This function is called automatically by super BaseGenericView
        public override func setupViewIfNeed() {
            // Use it to configure stuff on the genericView, depending on the value external/public variables
            // That are set after we instantiate the view controller, but before if has been presented
        }

        // This function is called automatically by super BaseGenericView
        public override func setupViewUIRx() {
            genericView.rxBtnTap.sink { [interactor] (some) in
                let request = VM.___VARIABLE_sceneName___.Something.Request(userId: "")
                interactor?.requestSomething(request: request)
            }.store(in: cancelBag)
    
        }

        // This function is called automatically by super BaseGenericView
        public override func setupNavigationUIRx() {
            // Add options to navigation bar
        }
    }
}

// MARK: Public Misc Stuff

extension VC.___VARIABLE_sceneName___ViewController {

}

// MARK: Private Misc Stuff

private extension VC.___VARIABLE_sceneName___ViewController {
    // THIS FUNCTION IS JUST FOR DEMONSTRATION PURPOSES. DELETE AFTER USING TEMPLATE
    // THIS FUNCTION IS JUST FOR DEMONSTRATION PURPOSES. DELETE AFTER USING TEMPLATE
    // THIS FUNCTION IS JUST FOR DEMONSTRATION PURPOSES. DELETE AFTER USING TEMPLATE
    private func doPrivateStuff() {
        let userId = genericView.subTitle
        let request = VM.___VARIABLE_sceneName___.Something.Request(userId: userId)
        self.interactor?.requestSomething(request: request)
    }
}

// MARK: DisplayLogicProtocol

extension VC.___VARIABLE_sceneName___ViewController: ___VARIABLE_sceneName___DisplayLogicProtocol {

    func displaySomething(viewModel: VM.___VARIABLE_sceneName___.Something.ViewModel) {
        // Setting up the view, option 1 : passing the view model
        genericView.setupWith(someStuff: viewModel)
    }

    func displayScreenInitialState(viewModel: VM.___VARIABLE_sceneName___.ScreenInitialState.ViewModel) {
        title = viewModel.title
        // Setting up the view, option 2 : setting the vars one by one
        genericView.subTitle = viewModel.subTitle
    }
}
