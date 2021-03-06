//
//  Created by Ricardo Santos on 27/02/2021.
//

#if !os(macOS)
import Foundation
import Combine
import UIKit

public extension RJSCombineCompatible {
    var editingChangedPublisher: AnyPublisher<String?, Never> {
        if let target = target as? UISearchTextField {
            return target.editingChangedPublisher
        } else {
            return AnyPublisher.never()
        }
    }
    var textDidChangePublisher: AnyPublisher<String?, Never> {
        if let target = target as? UISearchTextField {
            return target.textDidChangePublisher
        } else {
            return AnyPublisher.never()
        }
    }
}

public extension UISearchTextField {

    var textDidChangeNotificationPublisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self)
    }
    
    var textDidChangePublisher: AnyPublisher<String?, Never> {
        return textDidChangeNotificationPublisher
            .map { ($0.object as? UISearchTextField)?.text }
            .debounce(for: .milliseconds(Self.rjsDebounce), scheduler: RunLoop.main).eraseToAnyPublisher()
    }
        
}

public extension RJSCombineCompatibleProtocol where Self: UISearchTextField {

    var valueChangedPublisher: AnyPublisher<String?, Never> { editingChangedPublisher }

    var editingChangedPublisher: AnyPublisher<String?, Never> {
        RJSLib.UIControlPublisher(control: self, events: [.editingChanged]).map { $0.text }
            .debounce(for: .milliseconds(Self.rjsDebounce), scheduler: RunLoop.main).eraseToAnyPublisher()
            .eraseToAnyPublisher()
    }
}

fileprivate extension UISearchTextField {
     static var rjsDebounce = 500
}

fileprivate extension RJSLib {
    func sample() {
        
        let search = UISearchTextField()
        
        _ = search.editingChangedPublisher.sinkToResult { (_) in }
        _ = search.rjsCombine.editingChangedPublisher.sinkToResult { (_) in }
        
        _ = search.textDidChangePublisher.sinkToResult { (_) in }
        _ = search.rjsCombine.textDidChangePublisher.sinkToResult { (_) in }
        
        search.sendActions(for: .editingChanged)

    }
}
#endif
