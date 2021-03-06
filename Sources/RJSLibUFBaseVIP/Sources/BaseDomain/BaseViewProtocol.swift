//
//  Created by Ricardo Santos on 17/02/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public protocol RJS_BaseViewProtocol: AnyObject {
    func displayMessage(_ message: String, type: AlertType)
}
#endif
