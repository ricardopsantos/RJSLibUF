//
//  Created by Ricardo Santos on 27/02/2021.
//

import Foundation
import Combine
import UIKit

public extension RJSCombineCompatible {
    var touchUpInsidePublisher: AnyPublisher<UIButton, Never> { (target as? UIButton)!.touchUpInsidePublisher }
}

public extension RJSCombineCompatibleProtocol where Self: UIButton {
    var touchUpInsidePublisher: AnyPublisher<Self, Never> {
        RJSLib.UIControlPublisher(control: self, events:  [.touchUpInside]).eraseToAnyPublisher()
    }
}

fileprivate extension RJSLib {
    func sample() {
        let btn = UIButton()
        _ = btn.rjsPublisher(for: .touchUpInside).sinkToResult { (_) in }
        _ = btn.rjsCombine.touchUpInsidePublisher.sinkToResult { (_) in }
        _ = btn.touchUpInsidePublisher.sinkToResult { (_) in }
        
        btn.sendActions(for: .touchUpInside)

    }
}
