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
// Interactor will fetch the Domain objects, (from DataManager or WebAPI) and return that response
// to the Presenter. The Presenter will parse then into ViewModel objects
//
// The interactor contains your app’s business logic. The user taps and swipes in your UI in
// order to interact with your app. The view controller collects the user inputs from the UI
// and passes it to the interactor. It then retrieves some models and asks some workers to do the work.
//

extension I {
    class ___VARIABLE_sceneName___Interactor: RJS_BaseInteractorVIP, ___VARIABLE_sceneName___DataStoreProtocol {
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        var presenter: ___VARIABLE_sceneName___PresentationLogicProtocol?
        weak var basePresenter: BasePresenterVIPProtocol? { return presenter }

        // DataStoreProtocol Protocol vars...
        var dsSomeRandomModelA: SomeRandomModelA?
        var dsSomeRandomModelB: SomeRandomModelB?
    }
}

// MARK: Interator Mandatory BusinessLogicProtocol

extension I.___VARIABLE_sceneName___Interactor: BaseInteractorVIPMandatoryBusinessLogicProtocol {

    /// When the screen is loaded, this function is responsible to bind the View with some (temporary or final) data
    /// till the user have all the data loaded on the view. This will improve user experience.
    func requestScreenInitialState() {
        var response: VM.___VARIABLE_sceneName___.ScreenInitialState.Response!
        response = VM.___VARIABLE_sceneName___.ScreenInitialState.Response(title: "VIP",
                                                                           subTitle: "Tap me...")
        presenter?.presentScreenInitialState(response: response)

        // Update DataStore // <<-- DS Sample : Take notice
        // When passing Data from the Scene Router to other one, this will be the value that will be passed
        dsSomeRandomModelA = SomeRandomModelA(s1: "A: \(Date())")
        dsSomeRandomModelB = SomeRandomModelB(s1: "B: \(Date())")

    }

}

// MARK: Private Stuff

private extension I.___VARIABLE_sceneName___Interactor {

}

// MARK: BusinessLogicProtocol

extension I.___VARIABLE_sceneName___Interactor: ___VARIABLE_sceneName___BusinessLogicProtocol {

    // THIS FUNCTION IS JUST FOR DEMONSTRATION PURPOSES. DELETE AFTER USING TEMPLATE
    // THIS FUNCTION IS JUST FOR DEMONSTRATION PURPOSES. DELETE AFTER USING TEMPLATE
    // THIS FUNCTION IS JUST FOR DEMONSTRATION PURPOSES. DELETE AFTER USING TEMPLATE

    func requestSomething(request: VM.___VARIABLE_sceneName___.Something.Request) {

        presenter?.presentLoading(response: RJS_BaseDisplayLogicModels.Loading(isLoading: true))
        DispatchQueue.executeWithDelay(delay: 0.5) { [weak self] in
            if Bool.random() {
                let mockA1 = TemplateModel(id: "some id 1", state: "state_a - \(Date())")
                let response = VM.___VARIABLE_sceneName___.Something.Response(list: [mockA1],
                                                                              subTitle: "New subtitle \(Date())")
                self?.presenter?.presentSomething(response: response)
            } else {
                let response = VM.___VARIABLE_sceneName___.Something.Response(list: [], subTitle: "")
                self?.presenter?.presentSomething(response: response)
                self?.presenter?.presentStatus(response: RJS_BaseDisplayLogicModels.Status(message: "Try again!"))
            }
            self?.presenter?.presentLoading(response: RJS_BaseDisplayLogicModels.Loading(isLoading: false))

        }
    }
}

// MARK: Utils {

extension I.___VARIABLE_sceneName___Interactor {
    func presentError(error: Error) {

        let title = RJS_Utils.onDebug ? error.localizedDescription : "Messages.pleaseTryAgainLater.localised"
        let response = RJS_BaseDisplayLogicModels.Error(title: title)
        basePresenter?.presentError(response: response)
    }
}
