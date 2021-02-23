//
//  Created by Ricardo Santos on 11/07/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase

public protocol RJSColdCacheWithTTLProtocol {
    func getObject<T: Codable>(_ some: T.Type, withKey key: String, keyParams: [String]) -> T?
    func saveObject<T: Codable>(_ some: T, withKey key: String, keyParams: [String], lifeSpam: Int) -> Bool
    func allRecords() -> [RJS_DataModelEntity]
    func delete(key: String)
    func clean()
    func printReport()
}
