//
//  Created by Ricardo Santos on 22/01/2021.
//
#if !os(macOS)
import Foundation
import UIKit
//
import RJSLibUFBase

// MARK: - ViewController - DisplayLogic

public protocol BaseViewControllerVIPProtocol: class {
    func displayLoading(viewModel: RJS_BaseDisplayLogicModels.Loading)
    func displayError(viewModel: RJS_BaseDisplayLogicModels.Error)
    func displayWarning(viewModel: RJS_BaseDisplayLogicModels.Warning)
    func displayStatus(viewModel: RJS_BaseDisplayLogicModels.Status)
}

public extension RJSLib {
    
    class BaseViewControllerVIP: UIViewController, BaseViewControllerVIPProtocol, RJS_BaseViewProtocol {

        public var firstAppearance = true

        deinit {
            NotificationCenter.default.removeObserver(self)
        }

        open override func loadView() {
            super.loadView()
            doViewLifeCycle()
        }

        open override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            DispatchQueue.executeWithDelay(delay: 0.1) { [weak self] in
                guard let self = self else { return }
                self.firstAppearance = false
            }
        }

        open func displayWarning(viewModel: BaseDisplayLogicModels.Warning) {
            var message = "\(viewModel.title)"
            if !viewModel.message.isEmpty {
                message = message.isEmpty ? viewModel.message : "\(message)\n\n\(viewModel.message)"
            }
            displayMessage(message, type: .warning)
        }

        open func displayStatus(viewModel: BaseDisplayLogicModels.Status) {
            var message = "\(viewModel.title)"
            if !viewModel.message.isEmpty {
                message = message.isEmpty ? viewModel.message : "\(message)\n\n\(viewModel.message)"
            }
            displayMessage(message, type: .success)
        }

        open func displayLoading(viewModel: BaseDisplayLogicModels.Loading) {
            setActivityState(viewModel.isLoading)
        }

        open func displayError(viewModel: BaseDisplayLogicModels.Error) {
            var message = "\(viewModel.title)"
            if !viewModel.message.isEmpty {
                message = message.isEmpty ? viewModel.message : "\(message)\n\n\(viewModel.message)"
            }
            displayMessage(message, type: .error)
        }

        open func setupColorsAndStyles() {
            fatalError("Override me")
        }

        open func prepareLayoutCreateHierarchy() {
            fatalError("Override me")
        }

        open func prepareLayoutBySettingAutoLayoutsRules() {
            fatalError("Override me")
        }

        open func prepareLayoutByFinishingPrepareLayout() {
            fatalError("Override me")
        }
        
        //
        // MARK: - RJS_BaseViewProtocol
        //
        
        // Can (and should) be overriden
        public func displayMessage(_ message: String, type: AlertType) {
            self.showAlert(title: "\(type)", message: message)
        }
    }
}

//
// MARK: - Private
//

private extension RJS_BaseViewControllerVIP {

    func setActivityState(_ state: Bool) {
        if state {
            view.rjs.startLoading(style: .pack2_2)
        } else {
            view.rjs.stopLoading()
        }
    }

    func doViewLifeCycle() {
        prepareLayoutCreateHierarchy()           // DONT CHANGE ORDER
        prepareLayoutBySettingAutoLayoutsRules() // DONT CHANGE ORDER
        prepareLayoutByFinishingPrepareLayout()  // DONT CHANGE ORDER
        setupColorsAndStyles()                   // DONT CHANGE ORDER
    }
}
#endif
