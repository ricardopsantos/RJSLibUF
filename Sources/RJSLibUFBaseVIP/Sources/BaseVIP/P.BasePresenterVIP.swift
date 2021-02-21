//
//  Created by Ricardo Santos on 22/01/2021.
//
#if !os(macOS)
import Foundation
import UIKit
//
import RJSLibUFBase
extension RJSLib {
    open class BasePresenterVIP: BasePresenterVIPProtocol {
        public init () {}
        open weak var baseViewController: BaseViewControllerVIPProtocol? {
            fatalError("Override me on pressenter")
        }
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
    }
}

// MARK: - Presenter - PresentationLogic

/// [BasePresentationLogicProtocol] && [BaseDisplayLogicProtocol] must match
public protocol BasePresenterVIPProtocol: class {
    var baseViewController: BaseViewControllerVIPProtocol? { get }
    func presentLoading(response: RJS_BaseDisplayLogicModels.Loading)
    func presentError(response: RJS_BaseDisplayLogicModels.Error)
    func presentStatus(response: RJS_BaseDisplayLogicModels.Status)

    // Helper...
    func presentErrorGeneric()

}

/// Default implementation....
public extension BasePresenterVIPProtocol {
    func presentStatus(response: RJS_BaseDisplayLogicModels.Status) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = response
            self?.baseViewController?.displayStatus(viewModel: viewModel)
        }

    }

    func presentError(response: RJS_BaseDisplayLogicModels.Error) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = response
            self?.baseViewController?.displayError(viewModel: viewModel)
        }

    }

    func presentErrorGeneric() {
        DispatchQueue.main.async { [weak self] in
            let response = RJS_BaseDisplayLogicModels.Error(title: "Alert",
                                                        message: "Please try again latter")
            self?.presentError(response: response)
        }
    }

    func presentLoading(response: RJS_BaseDisplayLogicModels.Loading) {
        DispatchQueue.main.async { [weak self] in
            if let viewController = self?.baseViewController as? UIViewController {
                if response.isLoading {
                    viewController.view.rjs.startLoading(style: .pack2_2)
                } else {
                    viewController.view.rjs.stopLoading()
                }
            }
        }

    }
}
#endif
