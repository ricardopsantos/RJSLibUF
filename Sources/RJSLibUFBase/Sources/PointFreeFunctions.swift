//
//  Created by Ricardo Santos on 29/01/2021.
//

import Foundation

#if !os(macOS)
import UIKit

public func synced<T>(_ lock: Any, closure: () -> T) -> T {
    objc_sync_enter(lock)
    let r = closure()
    objc_sync_exit(lock)
    return r
}

// Screen width.
public var screenWidth: CGFloat {
    return screenSize.width
}

// Screen height.
public var screenHeight: CGFloat {
    return screenSize.height
}

public var screenSize: CGSize {
    return UIScreen.main.bounds.size
}
#endif
