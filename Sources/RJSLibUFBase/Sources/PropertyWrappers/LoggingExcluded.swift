//
//  LoggingExcluded.swift
//  RJSLibUFBase
//
//  Created by Santos, Ricardo Patricio dos  on 23/04/2021.
//

import Foundation

/**
 https://olegdreyman.medium.com/keep-private-information-out-of-your-logs-with-swift-bbd2fbcd9a40
 ```
 struct User {
     var identifier: String
     var handle: String
     @LoggingExcluded var name: String
     @LoggingExcluded var dateOfBirth: Date
     @LoggingExcluded var city: String
 }
 ```
 */
@propertyWrapper
struct LoggingExcluded<Value>: CustomStringConvertible, CustomDebugStringConvertible, CustomLeafReflectable {
    
    var wrappedValue: Value
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    var description: String {
        return "--redacted--"
    }
    
    var debugDescription: String {
        return "--redacted--"
    }
    
    var customMirror: Mirror {
        return Mirror(reflecting: "--redacted--")
    }
}
