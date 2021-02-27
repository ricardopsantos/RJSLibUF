//
//  Created by Ricardo Santos on 27/02/2021.
//

import Foundation
import Combine
import UIKit

public extension UISearchTextField {
    
    fileprivate static var rjsDebounce = 500

    var textDidChangeNotification:  NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self)
    }
    
    var textDidChangePublisher: AnyPublisher<String?, Never> {
        rjsTextDidChangePublisher
    }
    
    /// Equivalent to [var rjsValueChangedPublisher: AnyPublisher<String?, Never>]
    var rjsTextDidChangePublisher: AnyPublisher<String?, Never> {
        return self.textDidChangeNotification
            .map { ($0.object as? UISearchTextField)?.text }
            .debounce(for: .milliseconds(Self.rjsDebounce), scheduler: RunLoop.main).eraseToAnyPublisher()
    }
    
}

public extension RJSCombineCompatibleProtocol where Self: UISearchTextField {
   
    var valueChangedPublisher: AnyPublisher<String?, Never> {
        rjsValueChangedPublisher
    }

    /// Equivalent to [var rjsTextDidChangePublisher: AnyPublisher<String?, Never>]
    var rjsValueChangedPublisher: AnyPublisher<String?, Never> {
        RJSLib.UIControlPublisher(control: self, events:  [.editingChanged]).map { $0.text }
            .debounce(for: .milliseconds(Self.rjsDebounce), scheduler: RunLoop.main).eraseToAnyPublisher()
            .eraseToAnyPublisher()
    }
}
