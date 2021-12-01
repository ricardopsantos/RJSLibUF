//
//  Created by Ricardo Santos on 10/03/2021.
//

#if !os(macOS)
import Foundation
import UIKit
import SwiftUI

public extension RJSLibExtension where Target == UIViewController {
    
    var asAnyView: AnyView { target.asAnyView }
    
    func showAlertWithActions(title: String,
                              message: String,
                              actions: [UIAlertAction],
                              animated: Bool = true) {
        target.showAlertWithActions(title: title, message: message, actions: actions, animated: true)
    }
    
    func alert(title: String?,
               message: String?,
               preferredStyle: UIAlertController.Style = .actionSheet,
               actions: [RJSLib.AlertAction]) {
        target.alert(title: title, message: message, preferredStyle: preferredStyle, actions: actions)
    }
    
    func showOkAlert(title: String = "",
                     message: String,
                     actionTitle: String = "ok".localized,
                     completion: (() -> Void)? = nil,
                     animated: Bool = true) {
        target.showOkAlert(title: title, message: message, actionTitle: actionTitle, completion: completion, animated: animated)
        
    }
}

public extension UIViewController {

    var asAnyView: AnyView { RJS_ViewControllerRepresentable { self }.erased }
    
    func alert(title: String?,
               message: String?,
               preferredStyle: UIAlertController.Style = .actionSheet,
               actions: [RJSLib.AlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { item in
            let action = UIAlertAction(title: item.title, style: item.style) { _ in
                if let doAction = item.action {
                    doAction()
                }
            }
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }

    func showOkAlert(title: String = "",
                     message: String,
                     actionTitle: String = "ok".localized,
                     completion: (() -> Void)? = nil, animated: Bool = true) {
        let okAction = UIAlertAction.ok(title: actionTitle, completion: { completion?() })
        showAlertWithActions(title: title, message: message, actions: [okAction], animated: animated)
    }

    func showAlertWithActions(title: String,
                              message: String,
                              actions: [UIAlertAction],
                              animated: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach(alert.addAction)
        present(alert, animated: animated)
    }
}

public extension UIAlertAction {
    static var ok: UIAlertAction {
        ok {}
    }

    static func ok(title: String = "ok".localized, completion: @escaping () -> Void) -> UIAlertAction {
        UIAlertAction(
            title: title,
            style: .default,
            handler: { _ in
                completion()
            })
    }
}
#endif
