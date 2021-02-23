//
//  Created by Ricardo Santos on 23/02/2021.
//

import Foundation

public protocol RJSStorableKeyValueWithTTLProtocol {
    static func save(key: String, value: String, expireDate: Date?) -> Bool
    static func existsWith(key: String) -> Bool
    static func with(key: String) -> RJS_DataModelEntity?         // Returns CoreData @objc(DataModelEntity)
    static func with(keyPrefix: String) -> RJS_DataModelEntity?   // Returns CoreData @objc(DataModelEntity)
    static func allKeys() -> [String]
    static func allRecords() -> [RJS_DataModelEntity]             // Returns [CoreData @objc(DataModelEntity)]
    static func clean() -> Bool
    static func deleteWith(key: String) -> Bool
    static var baseDate: Date { get }
}
