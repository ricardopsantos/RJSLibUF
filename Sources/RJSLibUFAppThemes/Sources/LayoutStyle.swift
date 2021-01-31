//
//  Created by Ricardo Santos on 28/01/2021.
//

#if !os(macOS)
import Foundation
import UIKit

public extension UIButton {
    enum RJSLibUFLayoutStyle: String, CaseIterable {
        
        case notApplied
        case primary
        case secondary
        case secondaryDestructive
        case accept
        case reject
        case remind
        case inngage
        
        public typealias RawValue = String
        public init?(rawValue: RawValue) {
            if let some = Self.allCases.first(where: { $0.rawValue == rawValue }) {
                self = some
            } else {
                return nil
            }
        }
        
    }
}

public extension UILabel {
    
    enum RJSLibUFLayoutStyle: String, CaseIterable {
        
        case notApplied
        case navigationBarTitle
        case title
        case value
        case text
        case error
        
        public typealias RawValue = String
        public init?(rawValue: RawValue) {
            if let some = Self.allCases.first(where: { $0.rawValue == rawValue }) {
                self = some
            } else {
                return nil
            }
        }
    }
}
#endif
