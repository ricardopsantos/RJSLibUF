//
//  Created by Ricardo Santos on 19/02/2021.
//
#if !os(macOS)
import Foundation
import Combine
import UIKit

public extension RJSCombineCompatible {
    var onTurnedOnPublisher: AnyPublisher<Bool, Never> {
        if let target = target as? UISwitch {
            return target.onTurnedOnPublisher
        } else {
            return AnyPublisher.never()
        }
    }
}

public extension RJSCombineCompatibleProtocol where Self: UISwitch {
    var onTurnedOnPublisher: AnyPublisher<Bool, Never> {
        RJSLib.UIControlPublisher(control: self, events: [.allEditingEvents, .valueChanged]).map { $0.isOn }.eraseToAnyPublisher()
    }
}

fileprivate extension RJSLib {
    func sample() {
        let switcher = UISwitch()
        switcher.isOn = false
        let submitButton = UIButton()
        submitButton.isEnabled = false

        _ = switcher.onTurnedOnPublisher.assign(to: \.isEnabled, on: submitButton)
        _ = switcher.rjsCombine.onTurnedOnPublisher.assign(to: \.isEnabled, on: submitButton)
        
        switcher.isOn = true
        switcher.sendActions(for: .valueChanged)
        RJS_Logs.info(submitButton.isEnabled)
    }
}

#endif
