//
//
//  Created by Ricardo Santos on 22/03/2021.
//

import Foundation

#if !os(macOS)
import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(_ class: T.Type) {
        register(`class`, forCellReuseIdentifier: T.reusableIdentifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as! T
    }
}
#endif
