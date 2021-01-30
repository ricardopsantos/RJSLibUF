//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

// swiftlint:disable no_print line_length

import AVFoundation
import CoreLocation
import CoreData
#if !os(macOS)
import UIKit
#endif
//
import RJSLibUFBase

fileprivate extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}

// MARK: - RJSStorableKeyValueWithTTLProtocol

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

//
// MARK: - RJPSLibSimpleCacheProtocol
//

protocol CoreDataEntity_Protocol {
    static var entityName: String { get }
}

//
// MARK: - CoreData @objc(DataModelEntity) auxiliar values
//

extension RJS_DataModelEntity {
    public static var baseDate: Date { return Date() }
    internal static var validateMainThread = true
    internal static var entityName: String = "\(RJS_DataModelEntity.self)"

    public enum RecordType: String {
        case keyValueRecord // For general purpose saved records. Usually primitive and huge TTL
        case cachedRecord   // For cached records. Usually Codable and with TTL
    }
    internal enum RecordEncodingType: String {
        case plain
        case data
    }
}

//
// MARK: - RJPSLibColdCacheWithTTLProtocol implementation
//

extension RJS_DataModelEntity {
    
    private static func parseKeyParams(_ params: [String]) -> String {
        return "[" + params.joined(separator: ",") + "]"
    }
    
    private static func buildKey(_ key: String, _ keyParams: [String]) -> String {
        if !keyParams.isEmpty {
            return "\(key)_\(parseKeyParams(keyParams))"
        } else {
            return key
        }
    }
    
    public class RJPSLibColdCacheWithTTL: RJPSLibColdCacheWithTTLProtocol {

        private init() {}
        public static var shared = RJPSLibColdCacheWithTTL()

        public func getObject<T>(_ some: T.Type, withKey key: String, keyParams: [String]) -> T? where T: Decodable, T: Encodable {
            let composedKey = buildKey(key, keyParams)
            do {
                let cachedMaybe  = RJS_DataModelEntity.StorableKeyValue.with(key: composedKey)
                guard let cached = cachedMaybe, cached.expireDate != nil else { return nil }                      // Not found
                guard cached.expireDate!.timeIntervalSinceNow > baseDate.timeIntervalSinceNow else { return nil } // expired
                if let data1 = cached.value?.data(using: String.Encoding.utf8) {
                    return try JSONDecoder().decodeFriendly(T.self, from: data1)
                }
                if let data2 = cached.valueData {
                    return try JSONDecoder().decodeFriendly(T.self, from: data2)
                }
            } catch {
                assertionFailure("Error retrieving object with key [\(composedKey)]. Error [\(error)]")
            }
            return nil
        }
        
        public func saveObject<T>(_ some: T, withKey key: String, keyParams: [String], lifeSpam: Int) -> Bool where T: Decodable, T: Encodable {
            let composedKey = buildKey(key, keyParams)
            let computedKeyParams = parseKeyParams(keyParams)
            if let data = try? JSONEncoder().encode(some) {
                if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
                objc_sync_enter(self); defer { objc_sync_exit(self) }
                let object: RJS_DataModelEntity?
                if #available(iOS 10.0, *) {
                    object = RJS_DataModelEntity(context: RJS_DataModelManager.managedObjectContext)
                } else {
                    let entityDesc = NSEntityDescription.entity(forEntityName: entityName, in: RJS_DataModelManager.managedObjectContext)
                    object = RJS_DataModelEntity(entity: entityDesc!, insertInto: RJS_DataModelManager.managedObjectContext)
                }
                
                let checkSuccess = { }
                let saveNewRecordBlock = {
                    object!.keyBase    = key
                    object!.key        = composedKey // final key
                    object!.keyParams  = computedKeyParams
                    object!.value      = nil
                    object!.recordDate = baseDate
                    object!.expireDate = baseDate.adding(minutes: lifeSpam)
                    object!.encoding   = RecordEncodingType.data.rawValue
                    object!.valueData  = data
                    object!.valueType  = String(describing: type(of: some))
                    object!.recordType = RecordType.cachedRecord.rawValue
                    RJS_DataModelManager.saveContext()
                    checkSuccess()
                }
                if object != nil {
                    _ = StorableKeyValue.deleteWith(key: composedKey)
                    saveNewRecordBlock()
                } else {
                    saveNewRecordBlock()
                }
                return true
            }
            return false
        }

        public func clean() {
            _ = StorableKeyValue.deleteAllWith(recordType: .cachedRecord)
        }

        public func allRecords() -> [RJS_DataModelEntity] {
            return StorableKeyValue.allRecords().filter { $0.recordType == RecordType.cachedRecord.rawValue }
        }

        public func delete(key: String) {
            if let record = allRecords().filter({ (some) -> Bool in some.key == key }).first, let recordKey = record.key {
                _ = RJS_DataModelEntity.StorableKeyValue.deleteWith(key: recordKey)
            }
        }

        public func printReport() {
            var acc = ""
            var i = 0
            allRecords().forEach { (some) in
                i += 1
                acc = "\(acc)[\(i)] - 'key'=[\(some.key!)] | 'valueType'=[\(some.valueType!)] | 'expire'=[\(some.expireDate!)]\n"
            }
            RJS_Logs.info("\(#function) : \(acc)", tag: .rjsLib)
        }
    }
    
}

// MARK: - RJSStorableKeyValueWithExpireDate_Protocol implementation

extension RJS_DataModelEntity: CoreDataEntity_Protocol {
    
    public struct StorableKeyValue: RJSStorableKeyValueWithTTLProtocol {
        public static var baseDate: Date = RJS_DataModelEntity.baseDate
        
        private init() {}
        
        public static func save(key: String, value: String, expireDate: Date?=nil) -> Bool {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }

            let entityDesc = NSEntityDescription.entity(forEntityName: entityName, in: RJS_DataModelManager.managedObjectContext)
            let object: RJS_DataModelEntity? = RJS_DataModelEntity(entity: entityDesc!, insertInto: RJS_DataModelManager.managedObjectContext)
            
            let checkSuccess = { }
            let saveNewRecordBlock = {
                object!.key        = key
                object!.value      = value
                object!.recordDate = baseDate
                object!.expireDate = expireDate ?? baseDate.adding(minutes: 60 * 12 * 31)
                object!.encoding   = RecordEncodingType.plain.rawValue
                object!.keyBase    = nil
                object!.valueData  = nil
                object!.keyParams  = nil
                object!.valueType  = String(describing: type(of: value))
                object!.recordType = RecordType.keyValueRecord.rawValue
                RJS_DataModelManager.saveContext()
                checkSuccess()
            }
            if object != nil {
                _ = deleteWith(key: key)
                saveNewRecordBlock()
            } else {
                saveNewRecordBlock()
            }
            return true
        }
        
        public static func existsWith(key: String) -> Bool {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            if let record = with(key: key) {
                if baseDate > record.expireDate! {
                    _ = deleteWith(key: key)
                }
            }
            return with(key: key) != nil
        }
        
        public static func with(key: String) -> RJS_DataModelEntity? {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            let allRecordsCopy = allRecords()
            return allRecordsCopy.filter { (item) -> Bool in return item.key == key && item.expireDate! > baseDate }.first
        }
        
        public static func dateWith(key: String) -> Date? {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }

            func dateWith(_ dateToParse: String, dateFormat: String="yyyy-MM-dd'T'HH:mm:ssXXX") -> Date? {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = dateFormat
                if let result = dateFormatter.date(from: dateToParse) { return result }
                var detectDates: [Date]? { return try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue).matches(in: dateToParse, range: NSRange(location: 0, length: dateToParse.count)).compactMap { $0.date } }
                if let date = detectDates?.first { return date }
                return Date()
            }

            if let dateToParse = with(key: key)?.value {
                if let date = dateWith(dateToParse) {
                    return date
                }
            }
            return nil
        }
        
        public static func with(keyPrefix: String) -> RJS_DataModelEntity? {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            let allRecordsCopy = allRecords()
            return allRecordsCopy.filter { (item) -> Bool in return item.key!.hasPrefix(keyPrefix) && item.expireDate! > baseDate }.first
        }
        
        static private func delete(records: [RJS_DataModelEntity]) -> Bool {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            if !records.isEmpty {
                records.forEach({ (item) in
                    RJS_DataModelManager.managedObjectContext.delete(item)
                })
                RJS_DataModelManager.saveContext()
            }
            return !records.isEmpty
        }
        
        public static func deleteAllWith(recordType: RJS_DataModelEntity.RecordType) -> Bool {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            let allRecordsCopy = allRecords()
            let records = allRecordsCopy.filter({ (item) -> Bool in return item.recordType == recordType.rawValue })
            return delete(records: records)
        }
        
        public static func deleteWith(keyPrefix: String) -> Bool {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            let allRecordsCopy = allRecords()
            let records = allRecordsCopy.filter({ (item) -> Bool in return item.key!.hasPrefix(keyPrefix) })
            return delete(records: records)
        }
        
        public static func deleteWith(key: String) -> Bool {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            let allRecordsCopy = allRecords()
            let records = allRecordsCopy.filter({ (item) -> Bool in return item.key == key })
            guard records.count != 0 else { return false }
            return delete(records: records)
        }
        
        public static func clean() -> Bool {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            let allRecordsCopy = allRecords()
            guard !allRecordsCopy.isEmpty else { return false }
            return delete(records: allRecordsCopy)
        }
        
        public static func allRecords() -> [RJS_DataModelEntity] {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            do {
                let fetchResult = try RJS_DataModelManager.managedObjectContext.fetch(fetchRequest)
                if let items = fetchResult as? [RJS_DataModelEntity] {
                    return items
                }
            } catch {
                assertionFailure("\(error)")
            }
            return []
        }
        
        public static func allKeys() -> [String] {
            if validateMainThread && !Thread.isMainThread { assertionFailure("Not in main tread") }
            objc_sync_enter(self); defer { objc_sync_exit(self) }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            var result: [String] = []
            do {
                let fetchResult = try RJS_DataModelManager.managedObjectContext.fetch(fetchRequest)
                if let items = fetchResult as? [RJS_DataModelEntity] {
                    items.forEach { (some) in
                        if some.key != nil {
                            result.append(some.key!)
                        }
                    }
                }
            } catch {
                assertionFailure("\(error)")
            }
            return result
        }
        
    }
    
}
