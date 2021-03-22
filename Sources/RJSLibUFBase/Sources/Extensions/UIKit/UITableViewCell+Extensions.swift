
//
//  Created by Ricardo Santos on 22/03/2021.
//

import Foundation
import UIKit

public protocol ReusableTableViewCellProtocol {
    static var reusableIdentifier: String { get }
}

public extension ReusableTableViewCellProtocol  {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReusableTableViewCellProtocol { }

#warning("improve to deal with UICollectionViewCell")
public extension UITableView {
    func register<T: UITableViewCell>(_ class: T.Type) {
        register(`class`, forCellReuseIdentifier: T.reusableIdentifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as! T
    }
}
