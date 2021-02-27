//
//  Created by Ricardo Santos on 18/02/2021.
//

import Foundation
import Combine
import SwiftUI

//
// https://medium.com/eggs-design/building-a-state-driven-app-in-swiftui-using-state-machines-32379ca37283
// Building a state-driven app in SwiftUI using state machines
//

public extension RJSLib {
    
    enum HashableDataState<T: Hashable>: Hashable {
        public static func == (lhs: Self<T>, rhs: Self<T>) -> Bool {
            switch (lhs, rhs) {
            case (.notLoaded, .notLoaded):
                return true
            case (.loading, .loading):
                return true
            case (.loaded(let t1), .loaded(let t2)):
                return t1 == t2
            case (.error, .error):
                return true
            default:
                return false
            }
        }

        case notLoaded
        case loading
        case loaded(T)
        case error(Error)

        public var selfValue: Int {
            switch self {
            case .notLoaded: return 1
            case .loading: return 2
            case .loaded: return 3
            case .error: return 4
            }
        }

        public var value: T? {
            switch self {
            case .loaded(let t): return t
            default: return nil
            }
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(selfValue)
            switch self {
            case .loaded(let t):
                hasher.combine(t)
            default: ()
            }
        }
    }

}

fileprivate extension RJSLib {
        
    // The machine stores the current state in a variable that is read-only, and offers a publisher
    // that notifies any listeners every time the state is changed internally
    class StateMachine {
        enum State { case start, searching, loading, searchResults, error }
        enum Event { case startSearch, cancel, search, success, failure }

        private(set) var state: State {
            didSet { stateSubject.send(self.state) }
        }
        
        private let stateSubject: PassthroughSubject<State, Never>
        let statePublisher: AnyPublisher<State, Never>

        init(state: State) {
            self.state = state
            self.stateSubject = PassthroughSubject<State, Never>()
            self.statePublisher = self.stateSubject.eraseToAnyPublisher()
        }
    }
}

fileprivate extension RJSLib.StateMachine {

    func tryEvent(_ event: Event) {
        if let state = nextState(for: event) {
            self.state = state
        }
    }
    
    func nextState(for event: Event) -> State? {
        switch state {
        case .start:
            switch event {
            case .startSearch: return .searching
            case .cancel, .search, .success, .failure: return nil
            }
        case .searching: return nil
        case .loading: return nil
        case .searchResults: return nil
        case .error:  return nil
        }
    }
}

fileprivate extension RJSLib {

    func sample2() {
                
        class ContentViewModel: ObservableObject {
            private let stateMachine: StateMachine
            private var stateCancellable: AnyCancellable?

            @Published var searchText: String = ""
            @Published var state: StateMachine.State
            @Published var isSearching: Bool = false

            var showSearchCancelButton: Bool {
                return stateMachine.state == .searching
            }
          
            init(stateMachine: StateMachine) {
                self.stateMachine = stateMachine
                self.state = stateMachine.state
                self.stateCancellable = stateMachine.statePublisher.sink { [weak self] state in
                    self?.state = state
                }
            }
          
            func searchStatusChanged(_ value: /*SearchBar.Status*/ String) {
            
            }
        }
    }
}
    
fileprivate extension RJSLib {
    
    func sample() {
        struct SomethingHashable: Hashable {
            public var currencyCode: String
            public func hash(into hasher: inout Hasher) {
                hasher.combine(currencyCode)
            }
        }

        var state: RJS_ScreenState<SomethingHashable?> = .notLoaded
        RJS_Logs.info(state)
         
        state = RJS_ScreenState.loaded(SomethingHashable(currencyCode: "EUR"))
        RJS_Logs.info(state)

    }
}
