//
//  Created by Ricardo Santos on 22/01/2021.
//
#if !os(macOS)
import Foundation
import Combine
//
import RJSLibUFBase

// MARK: - Interactor - Business Logic

public protocol BaseInteractorVIPMandatoryBusinessLogicProtocol {
    var basePresenter: BasePresenterVIPProtocol? { get }
    func requestScreenInitialState()
}

extension RJSLib {
    open class BaseInteractorVIP {
        public init() { }
        
        public func handleSubscriber<T>(result: Subscribers.Completion<T>) {
            switch result {
            case .finished: _ = ()
            case .failure(let reason):
                let model = BaseDisplayLogicModels.Error(title: "\(reason)")
                (self as? BaseInteractorVIPMandatoryBusinessLogicProtocol)?.basePresenter?.presentError(response: model)
            }
        }
    }
}
#endif
