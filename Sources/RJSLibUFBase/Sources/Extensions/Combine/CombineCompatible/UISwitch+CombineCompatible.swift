//
//  Created by Ricardo Santos on 19/02/2021.
//
#if !os(macOS)
import Foundation
import Combine
import UIKit

public extension RJSCombineCompatible {
    var onTurnedOn: AnyPublisher<Bool, Never> { (target as? UISwitch)!.isOnPublisher }
}

public extension RJSCombineCompatibleProtocol where Self: UISwitch {
    var isOnPublisher: AnyPublisher<Bool, Never> {
        RJSLib.UIControlPublisher(control: self, events:  [.allEditingEvents, .valueChanged]).map { $0.isOn }.eraseToAnyPublisher()
    }
}

fileprivate extension RJSLib {
    func sample() {
        let switcher = UISwitch()
        switcher.isOn = false
        let submitButton = UIButton()
        submitButton.isEnabled = false

        _ = switcher.isOnPublisher.assign(to: \.isEnabled, on: submitButton)
        _ = switcher.rjsCombine.onTurnedOn.assign(to: \.isEnabled, on: submitButton)
        
        switcher.isOn = true
        switcher.sendActions(for: .valueChanged)
        print(submitButton.isEnabled)
    }
}

#endif
