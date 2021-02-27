//
//  Created by Ricardo Santos on 27/02/2021.
//

import Foundation
import Combine
import UIKit

public extension RJSCombineCompatible {
    var valueChangedPublisher: AnyPublisher<String?, Never> { (target as? UISearchTextField)!.valueChangedPublisher }
    var textDidChangePublisher: AnyPublisher<String?, Never> { (target as? UISearchTextField)!.textDidChangePublisher }
    var textDidChangeNotification: NotificationCenter.Publisher { (target as? UISearchTextField)!.textDidChangeNotification }
}


public extension UISearchTextField {

    var textDidChangeNotification:  NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self)
    }
    
    var textDidChangePublisher: AnyPublisher<String?, Never> {
        return self.textDidChangeNotification
            .map { ($0.object as? UISearchTextField)?.text }
            .debounce(for: .milliseconds(Self.rjsDebounce), scheduler: RunLoop.main).eraseToAnyPublisher()
    }
    
}

public extension RJSCombineCompatibleProtocol where Self: UISearchTextField {

    var valueChangedPublisher: AnyPublisher<String?, Never> {
        RJSLib.UIControlPublisher(control: self, events:  [.editingChanged]).map { $0.text }
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
        
        _ = search.valueChangedPublisher.sinkToResult { (_) in }
        _ = search.rjsCombine.valueChangedPublisher.sinkToResult { (_) in }
        
        _ = search.textDidChangePublisher.sinkToResult { (_) in }
        _ = search.rjsCombine.textDidChangePublisher.sinkToResult { (_) in }
        
        search.sendActions(for: .editingChanged)

    }
}
