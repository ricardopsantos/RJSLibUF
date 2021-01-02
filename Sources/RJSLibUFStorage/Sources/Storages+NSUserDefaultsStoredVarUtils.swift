//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase

public extension RJSLib.Storages {
    struct NSUserDefaultsStoredVarUtils {
        private init() {}
        
        @discardableResult public static func getIntWithKey(_ key: String) -> Int {
            if let value = RJS_UserDefaults.getWith(key: key) as? Int {
                return value
            } else if let value = RJS_UserDefaults.getWith(key: key) as? String {
                return Int(value) ?? 0
            }
            return 0
        }
        
        @discardableResult public static func setIntWithKey(_ key: String, value: Int) -> Int {
            RJS_UserDefaults.save("\(value)" as AnyObject, key: key)
            return getIntWithKey(key)
        }
        
        @discardableResult public static func incrementIntWithKey(_ key: String) -> Int {
            let stored = getIntWithKey(key)
            RJS_UserDefaults.save("\(stored+1)" as AnyObject, key: key)
            return getIntWithKey(key)
        }
        
        @discardableResult public static func decrementIntWithKey(_ key: String) -> Int {
            let stored = getIntWithKey(key)
            RJS_UserDefaults.save("\(stored-1)" as AnyObject, key: key)
            return getIntWithKey(key)
        }
    }
}
