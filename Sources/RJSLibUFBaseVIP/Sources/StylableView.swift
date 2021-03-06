//
//  Created by Ricardo Santos on 22/01/2021.
//
#if !os(macOS)
import Foundation
import UIKit

// Future way to handle apps DarkMode (on progress)

public protocol StylableProtocol: class {

}

open class StylableView: UIView, StylableProtocol {

}
#endif
