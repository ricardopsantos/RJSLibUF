//
//  Created by Ricardo Santos on 22/01/2021.
//
#if !os(macOS)
import Foundation
import UIKit
//
import RJSLibUFBase

public extension RJSLib {
    
    class BaseGenericViewControllerVIP<T: StylableView>: BaseViewControllerVIP {

        public let cancelBag = CancelBag()
        deinit {
            if genericView != nil {
                genericView.removeFromSuperview()
            }
        }

        public var genericView: T!

        open override func loadView() {
            super.loadView()
            // Setup Generic View
            setup()
            genericView = T()
            view.addSubview(genericView)
            genericView.layouts.edgesToSuperview()
            setupViewUIRx()
        }

        open func setup() {
            fatalError("Override me")
        }

        open override func viewDidLoad() {
            super.viewDidLoad()
            setupViewIfNeed()
        }

        open override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            setupNavigationUIRx()
        }

        open override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            DispatchQueue.executeWithDelay(delay: 0.1) { [weak self] in
                self?.firstAppearance = false
            }
        }

        open func setupViewIfNeed() {
            fatalError("Override me")
        }

        open func setupNavigationUIRx() {
            fatalError("Override me")
        }

        open func setupViewUIRx() {
            fatalError("Override me")
        }
    }
}
#endif
