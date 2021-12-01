//
//  Created by Ricardo Santos on 22/01/2021.
//
#if !os(macOS)
import Foundation
import UIKit
//
import RJSLibUFBase

// MARK: - ViewController - DisplayLogic

public protocol BaseViewControllerProtocol: AnyObject {
    func displayLoading(viewModel: RJS_BaseDisplayLogicModels.Loading)
    func displayError(viewModel: RJS_BaseDisplayLogicModels.Error)
    func displayWarning(viewModel: RJS_BaseDisplayLogicModels.Warning)
    func displayStatus(viewModel: RJS_BaseDisplayLogicModels.Status)
}

public extension RJSLib {
    
    class BaseViewController: UIViewController, BaseViewControllerProtocol, RJS_BaseViewProtocol {

        public private (set) var firstAppearance = true // public to read, private to set...

        deinit {
            NotificationCenter.default.removeObserver(self)
        }

        open override func loadView() {
            super.loadView()
            doViewLifeCycle()
        }

        open override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if firstAppearance {
                viewWillFirstAppear()
            }
        }
        
        open func viewWillFirstAppear() {
            guard firstAppearance else { return }
        }
        
        open override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            firstAppearance = false
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

private extension RJS_BaseViewController {

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
