//
//  Created by Ricardo Santos on 27/02/2021.
//

import Foundation
import Combine
import UIKit

public extension RJSCombineCompatibleProtocol where Self: UIButton {

    var touchUpInsidePublisher: AnyPublisher<Self, Never> {
        rjsTouchUpInsidePublisher
    }
    
    var rjsTouchUpInsidePublisher: AnyPublisher<Self, Never> {
        RJSLib.UIControlPublisher(control: self, events:  [.touchUpInside]).eraseToAnyPublisher()
    }
}
