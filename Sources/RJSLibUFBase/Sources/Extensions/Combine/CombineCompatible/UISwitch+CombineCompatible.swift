//
//  Created by Ricardo Santos on 19/02/2021.
//
#if !os(macOS)
import Foundation
import Combine
import UIKit

/*:
 ## Solving the UISwitch KVO problem
 #### As the `UISwitch.isOn` property does not support KVO this extension can become handy.
 */

public extension RJSCombineCompatibleProtocol where Self: UISwitch {
    // As the `UISwitch.isOn` property does not support KVO this publisher can become handy.
    // The only downside is that it does not work with programmatically changing `isOn`, but it only responds to UI changes.
    var isOnPublisher: AnyPublisher<Bool, Never> {
        rjsIsOnPublisher
    }
    
    var rjsIsOnPublisher: AnyPublisher<Bool, Never> {
        RJSLib.UIControlPublisher(control: self, events:  [.allEditingEvents, .valueChanged]).map { $0.isOn }.eraseToAnyPublisher()
    }
}


extension RJSLib {
    private func switchRJSCombineCompatibleProtocolSample() {
        let switcher = UISwitch()
        switcher.isOn = false
        let submitButton = UIButton()
        submitButton.isEnabled = false

        switcher.isOnPublisher.assign(to: \.isEnabled, on: submitButton)

        /// As the `isOn` property is not sending out `valueChanged` events itself, we need to do this manually here.
        /// This is the same behavior as it would be if the user switches the `UISwitch` in-app.
        switcher.isOn = true
        switcher.sendActions(for: .valueChanged)
        print(submitButton.isEnabled)
        //: [Next](@next)
    }
}

#endif
