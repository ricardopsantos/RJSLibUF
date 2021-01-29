//
//  CacheProtocols.swift
//  RJPSLib
//
//  Created by Ricardo Santos on 11/07/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase

// MARK: - RJPSLibLiveSimpleCacheProtocol

public protocol RJPSLibHotCacheProtocol {
    func add(object: AnyObject, withKey: String)
    func get(key: String) -> AnyObject?
    func delete(key: String)
    func clean()
}

// MARK: - RJPSLibColdCacheWithTTLProtocol

public protocol RJPSLibColdCacheWithTTLProtocol {
    func getObject<T: Codable>(_ some: T.Type, withKey key: String, keyParams: [String]) -> T?
    func saveObject<T: Codable>(_ some: T, withKey key: String, keyParams: [String], lifeSpam: Int) -> Bool
    func allRecords() -> [RJS_DataModelEntity]
    func delete(key: String)
    func clean()
    func printReport()
}

public extension RJSLib.Storages {
    enum CacheStrategy: Hashable {
        case cacheNoLoad    // Use cache only
        case noCacheLoad    // Cache ignored, and returns latest available value
        case cacheElseLoad  // Will use cache if available, else returns latest available value (good because avoids server calls)
        case cacheAndLoad   // Can emit twice, one for cache (if available) and other with the latest available value
        public var canUseCache: Bool {
            return self != .noCacheLoad
        }
    }
}
