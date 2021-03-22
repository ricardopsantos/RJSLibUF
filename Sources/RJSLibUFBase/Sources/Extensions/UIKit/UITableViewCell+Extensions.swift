//
//  Created by Ricardo Santos on 22/03/2021.
//

import Foundation
#if !os(macOS)
import UIKit

public protocol ReusableTableViewCellProtocol {
    static var reusableIdentifier: String { get }
}

public extension ReusableTableViewCellProtocol {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReusableTableViewCellProtocol { }
extension UICollectionViewCell: ReusableTableViewCellProtocol { }

#endif
