//
//  Created by Ricardo Santos on 23/02/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public extension RJSLibExtension where Target == UICollectionView {
    func deinitialize() { target.deinitialize() }
    func safelySelect(rowAt indexPath: IndexPath) { target.safelySelect(rowAt: indexPath) }
}

public extension UICollectionView {

    func deinitialize() {
        dataSource = nil
        delegate = nil
    }

    func safelySelect(rowAt indexPath: IndexPath) {
        selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        delegate?.collectionView?(self, didSelectItemAt: indexPath)
    }
    
    func register<T: UICollectionViewCell>(_ class: T.Type) {
        register(`class`, forCellWithReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as! T
    }
}
#endif
