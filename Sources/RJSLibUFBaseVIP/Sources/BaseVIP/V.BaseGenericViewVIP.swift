//
//  Created by Ricardo Santos on 22/01/2021.
//
#if !os(macOS)
import Foundation
import UIKit
import Combine
//
import RJSLibUFBase

extension RJSLib {

    open class BaseGenericViewVIP: StylableView, RJS_BaseViewProtocol {

        public let cancelBag = CancelBag()
        public init() {
            super.init(frame: .zero)
            doViewLifeCycle()
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            doViewLifeCycle()
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            doViewLifeCycle()
        }

        private func doViewLifeCycle() {
            prepareLayoutCreateHierarchy()           // DONT CHANGE ORDER
            prepareLayoutBySettingAutoLayoutsRules() // DONT CHANGE ORDER
            prepareLayoutByFinishingPrepareLayout()  // DONT CHANGE ORDER
            setupViewUIRx()                          // DONT CHANGE ORDER
            setupColorsAndStyles()
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

        open func setupColorsAndStyles() {
            fatalError("Override me")
        }

        open func setupViewUIRx() {
            fatalError("Override me")
        }
        
        //
        // MARK: - RJS_BaseViewProtocol
        //
        
        // Can (and should) be overriden
        public func displayMessage(_ message: String, type: AlertType) {
            if let viewController = self.viewController as? RJS_BaseViewControllerVIP {
                viewController.displayMessage(message, type: type)
            } else {
                RJS_Logs.error("Failed to display [\(message)]")
            }
        }
    }
}
#endif
