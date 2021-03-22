//
//  Created by Ricardo Santos on 27/02/2021.
//

#if !os(macOS)
import Foundation
import Combine
import UIKit

public extension RJSCombineCompatible {
    var touchUpInsidePublisher: AnyPublisher<UIControl, Never> { target.touchUpInsidePublisher }
}

public extension RJSCombineCompatibleProtocol where Self: UIControl {
    var touchUpInsidePublisher: AnyPublisher<Self, Never> {
        RJSLib.UIControlPublisher(control: self, events: [.touchUpInside]).eraseToAnyPublisher()
    }
}

fileprivate extension RJSLib {
    func sample() {
        let btn = UIButton()
        _ = btn.publisher(for: .touchUpInside).sinkToResult { (_) in }
        _ = btn.rjsCombine.touchUpInsidePublisher.sinkToResult { (_) in }
        _ = btn.touchUpInsidePublisher.sinkToResult { (_) in }

        btn.rjs.onTouchUpInside { }
        btn.onTouchUpInside { }
        
        btn.sendActions(for: .touchUpInside)

    }
}
#endif
