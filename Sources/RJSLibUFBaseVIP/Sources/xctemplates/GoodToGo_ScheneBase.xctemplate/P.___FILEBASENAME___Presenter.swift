//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
//
import RJSLibUFBase

//
// After the interactor produces some results, it passes the response to the presenter.
// The presenter then marshal the response into view models suitable for display.
// It then passes the view models back to the view controller for display to the user.
//
// Now that we have the Response from the Interactor, it’s time to format it
// into a ViewModel and pass the result back to the ViewController. Presenter will be
// in charge of the presentation logic. This component decides how the data will be presented to the user.
//

extension P {
    class ___VARIABLE_sceneName___Presenter: RJS_BasePresenterVIP {
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        weak var viewController: (___VARIABLE_sceneName___DisplayLogicProtocol)?

        override weak var baseViewController: BaseViewControllerVIPProtocol? {
            return viewController
        }
    }
}

// MARK: PresentationLogicProtocol

extension P.___VARIABLE_sceneName___Presenter {

}

// MARK: PresentationLogicProtocol

extension P.___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresentationLogicProtocol {

    // Used By Interactor (exclusively)
    func presentScreenInitialState(response: VM.___VARIABLE_sceneName___.ScreenInitialState.Response) {
        let title = response.title.uppercased()
        let subTitle = response.subTitle.lowercased()
        let viewModel = VM.___VARIABLE_sceneName___.ScreenInitialState.ViewModel(title: title,
                                                                                 subTitle: subTitle,
                                                                                 screenLayout: .layoutA)
        viewController?.displayScreenInitialState(viewModel: viewModel)
    }

    // Used By Interactor (exclusively)
    func presentSomething(response: VM.___VARIABLE_sceneName___.Something.Response) {
        // Presenter will transform response object in something that the View can process/read
        let subTitle = response.subTitle.uppercased()
        let imageName = "ImagesNames.noInternet.rawValue"
        let someListA = response.listA
            .map { VM.___VARIABLE_sceneName___.TableItem(enabled: true,
                                                  image: imageName,
                                                  title: $0.id,
                                                  subtitle: $0.state?.uppercased() ?? "N.A.",
                                                  cellType: .cellType1)
            }
        let someListB = response.listB
            .map { VM.___VARIABLE_sceneName___.TableItem(enabled: true,
                                                         image: imageName,
                                                  title: $0.id,
                                                  subtitle: $0.state?.uppercased() ?? "N.A.",
                                                  cellType: .cellType2)
            }
        let sum = someListA.count + someListB.count
        let viewModel = VM.___VARIABLE_sceneName___.Something.ViewModel(subTitle: subTitle,
                                                                        someValue: "\(sum)",
            someListSectionATitle: "\(someListA.count) A elements",
            someListSectionBTitle: "\(someListB.count) B elements",
            someListSectionAElements: someListA,
            someListSectionBElements: someListB)
        viewController?.displaySomething(viewModel: viewModel)
    }

}
