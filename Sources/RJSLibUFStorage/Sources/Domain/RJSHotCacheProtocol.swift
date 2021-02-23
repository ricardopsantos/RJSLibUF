//
//  Created by Ricardo Santos on 23/02/2021.
//

import Foundation

public protocol RJSHotCacheProtocol {
    func add(object: AnyObject, withKey: String)
    func get(key: String) -> AnyObject?
    func delete(key: String)
    func clean()
}
