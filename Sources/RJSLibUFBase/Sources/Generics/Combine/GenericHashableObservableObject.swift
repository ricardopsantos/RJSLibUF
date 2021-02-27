//
//  Created by Ricardo Santos on 27/02/2021.
//

#if !os(macOS)
import Foundation
import Combine
import SwiftUI
import UIKit

/// With `var state = PassthroughSubject<RJS_ScreenState<T>, Never>`
public typealias RJS_GenericHashableObservableStateObjectV1 = RJSLib.GenericObservableStateContainerV1

/// With `var state: RJS_ScreenState<T>?`
public typealias RJS_GenericHashableObservableStateObjectV2 = RJSLib.GenericObservableStateContainerV2

/// With `var value = PassthroughSubject<T, Never>()`
public typealias RJS_GenericHashableObservableObjectV1 = RJSLib.GenericObservableContainerV1

/// With `var value: T?`
public typealias RJS_GenericHashableObservableObjectV2 = RJSLib.GenericObservableContainerV2

extension RJSLib {
    
    //
    // MARK: With RJS_ScreenState<T: Hashable> associated
    //
    
    public class GenericObservableStateContainerV1<T: Hashable>: ObservableObject {
        public init() { }
        public var state = PassthroughSubject<RJS_ScreenState<T>, Never>()
    }
    
    public class GenericObservableStateContainerV2<T: Hashable>: ObservableObject {
        public init() { }
        public var willChange = PassthroughSubject<GenericObservableStateContainerV2<T>, Never>()
        public var didChange = PassthroughSubject<GenericObservableStateContainerV2<T>, Never>()
        public var state: RJS_ScreenState<T>? {
            willSet {
                willChange.send(self)
            }
            didSet {
                didChange.send(self)
            }
        }
    }
    
    //
    // MARK: With <T: Hashable> associated
    //
    
    public class GenericObservableContainerV1<T: Hashable>: ObservableObject {
        public init() { }
        public var value = PassthroughSubject<T, Never>()
    }
    
    public class GenericObservableContainerV2<T: Hashable>: ObservableObject {
        public init() { }
        public var willChange = PassthroughSubject<GenericObservableContainerV2<T>, Never>()
        public var didChange = PassthroughSubject<GenericObservableContainerV2<T>, Never>()
        public var value: T? {
            willSet {
                willChange.send(self)
            }
            didSet {
                didChange.send(self)
            }
        }
    }
    
    fileprivate class NonGenericSampleObservableStateContainerV1: ObservableObject {
        var state = PassthroughSubject<RJS_ScreenState<RJSLib.VM_SampleTableItem>, Never>()
    }

    fileprivate class NonGenericSampleObservableStateContainerV2: ObservableObject {
        var willChange = PassthroughSubject<NonGenericSampleObservableStateContainerV2, Never>()
        var didChange = PassthroughSubject<NonGenericSampleObservableStateContainerV2, Never>()
        var state: RJS_ScreenState<RJSLib.VM_SampleTableItem>? {
            willSet {
                willChange.send(self)
            }
            didSet {
                didChange.send(self)
            }
        }
    }

}

extension RJSLib {
    
    struct VM_SampleTableItem: Hashable {

        let enabled: Bool
        let title: String
        let subtitle: String

        func hash(into hasher: inout Hasher) {
            hasher.combine(enabled)
            hasher.combine(title)
            hasher.combine(subtitle)

        }
        init(enabled: Bool = true, title: String, subtitle: String = "") {
            self.enabled = enabled
            self.title = title
            self.subtitle = subtitle
        }
    }
}

fileprivate extension RJSLib {
    
    class SomeView: UIView {
        public let cancelBag = CancelBag()
        var viewStateBinderA = NonGenericSampleObservableStateContainerV1()
        var viewStateBinderB = NonGenericSampleObservableStateContainerV2()
        var viewStateBinderC = RJS_GenericHashableObservableStateObjectV1<RJSLib.VM_SampleTableItem>()
        var viewStateBinderD = RJS_GenericHashableObservableStateObjectV2<RJSLib.VM_SampleTableItem>()
        
        public func setupViewUIRx() {

            viewStateBinderA.state.sink { [weak self] (state) in
                guard let self = self else { return }
                self.handle(state: state)
            }.store(in: cancelBag)
            
            viewStateBinderB.didChange.sink { [weak self] (some) in
                guard let self = self, let state = some.state else { return }
                self.handle(state: state)
            }.store(in: cancelBag)

            viewStateBinderC.state.sink { [weak self] (state) in
                guard let self = self else { return }
                self.handle(state: state)
            }.store(in: cancelBag)
            
            viewStateBinderD.didChange.sink { [weak self] (some) in
                guard let self = self, let state = some.state else { return }
                self.handle(state: state)
            }.store(in: cancelBag)

        }
        
        func handle(state: RJS_ScreenState<RJSLib.VM_SampleTableItem>) {
            RJS_Utils.executeInMainTread { [weak self] in
                guard let self = self else { return }
                switch state {
                case .notLoaded:
                    RJS_Logs.info("notLoaded")
                case .loading: _ = ()
                    RJS_Logs.info("loading")
                case .loaded(let model):
                    RJS_Logs.info("loaded \(model)")
                case .error(let error):
                    RJS_Logs.error("error \(error)")
                }
            }
        }
    }
    
    struct VM_SomeViewModel {
        
        @ObservedObject var viewStateBinderA: NonGenericSampleObservableStateContainerV1
        @ObservedObject var viewStateBinderB: NonGenericSampleObservableStateContainerV2
        
        @ObservedObject var viewStateBinderC: RJS_GenericHashableObservableStateObjectV1<VM_SampleTableItem>
        @ObservedObject var viewStateBinderD: RJS_GenericHashableObservableStateObjectV2<VM_SampleTableItem>
        
        init(viewStateBinderA: NonGenericSampleObservableStateContainerV1,
             viewStateBinderB: NonGenericSampleObservableStateContainerV2,
             viewStateBinderC: RJS_GenericHashableObservableStateObjectV1<VM_SampleTableItem>,
             viewStateBinderD: RJS_GenericHashableObservableStateObjectV2<VM_SampleTableItem>) {
            self.viewStateBinderA = viewStateBinderA
            self.viewStateBinderB = viewStateBinderB
            self.viewStateBinderC = viewStateBinderC
            self.viewStateBinderD = viewStateBinderD
        }
        
        func fetch() {
            viewStateBinderA.state.send(.loading)
            viewStateBinderC.state.send(.loading)
            viewStateBinderB.state = .loading
            viewStateBinderD.state = .loading
        }
    }
    
    class SomeViewController: UIViewController {
        var viewModel: VM_SomeViewModel!
        let genericView = SomeView()
        override func loadView() {
            super.loadView()
            viewModel = VM_SomeViewModel(viewStateBinderA: genericView.viewStateBinderA,
                                         viewStateBinderB: genericView.viewStateBinderB,
                                         viewStateBinderC: genericView.viewStateBinderC,
                                         viewStateBinderD: genericView.viewStateBinderD)
            viewModel.fetch()
        }
    }
}
#endif
