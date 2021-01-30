//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
#if !os(macOS)
    import UIKit
#endif

public extension RJSLib {
    
     struct Convert {
        private init() {}
        
        public struct Base64 {
            private init() {}
            
            public static func isBase64(_ testString: String) -> Bool {
                if let decodedData = Data(base64Encoded: testString, options: NSData.Base64DecodingOptions(rawValue: 0)) {
                    let result     = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue)
                    return result != nil
                }
                return false
            }
            
            public static func toPlainString(_ base64Encoded: String) -> String? {
                if let decodedData = Data(base64Encoded: base64Encoded, options: NSData.Base64DecodingOptions(rawValue: 0)) {
                    if let result = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
                        return result as String
                    }
                }
                return nil
            }
            
            public static func toB64String(_ anyObject: AnyObject) -> String? {
                if let data = anyObject as? Data {
                    return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                }
                
                if let string = anyObject as? String, let data = string.data(using: String.Encoding.utf8) {
                    return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                }
                
                #if !os(macOS)
                if let image = anyObject as? UIImage, let data: Data = image.pngData() {
                    return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                }
                #endif
                RJS_Utils.assert(false, message: RJS_Constants.notPredicted)

                return nil
            }
        }
        
        private static func removeInvalidChars(_ text: String) -> String {
            var result = text.replacingOccurrences(of: "\n", with: "")
            result     = result.replacingOccurrences(of: " ", with: "")
            return result
        }
        
        public static func toBinary(_ some: Int) -> String {
            return String(some, radix: 2)
        }
        
        public static func toDate(_ dateToParse: AnyObject) -> Date? {
            return Date.with("\(dateToParse)")
        }

        @available(*, deprecated)
        /* public */
        static func toCGFloat(_ string: String?) -> CGFloat? {
            guard string != nil else { return nil }
            if let some = NumberFormatter().number(from: removeInvalidChars(string!)) {
                return CGFloat(truncating: some)
            }
            if let some = NumberFormatter().number(from: removeInvalidChars(string!.replace(",", with: "."))) {
                return CGFloat(truncating: some)
            }
            RJS_Logs.warning("Fail on converting [\(String(describing: string))]", tag: .rjsLib)
            return nil
        }

        @available(*, deprecated)
        /* public */
        static func toBool(_ string: String?) -> Bool? {
            guard string != nil else { return nil }
            if let some = NumberFormatter().number(from: removeInvalidChars(string!)) {
                return Bool(truncating: some)
            }
            RJS_Logs.warning("Fail on converting [\(String(describing: string))]", tag: .rjsLib)
            return nil
        }

        @available(*, deprecated)
        /* public */
        static func toDouble(_ string: String?) -> Double? {
            guard string != nil else { return nil }
            if let some = NumberFormatter().number(from: removeInvalidChars(string!)) {
                return Double(truncating: some)
            }
            if let some = NumberFormatter().number(from: removeInvalidChars(string!.replace(",", with: "."))) {
                return Double(truncating: some)
            }
            RJS_Logs.warning("Fail on converting [\(String(describing: string))]", tag: .rjsLib)
            return nil
        }

        @available(*, deprecated)
        /* public */
        static func toFloat(_ string: String?) -> Float? {
            guard string != nil else { return nil }
            if let some = NumberFormatter().number(from: removeInvalidChars(string!)) {
                return Float(truncating: some)
            }
            if let some = NumberFormatter().number(from: removeInvalidChars(string!.replace(",", with: "."))) {
                return Float(truncating: some)
            }
            RJS_Logs.warning("Fail on converting [\(String(describing: string))]", tag: .rjsLib)
            return nil
        }

        @available(*, deprecated)
        /* public */
        static func toInt(_ string: String?) -> Int? {
            guard string != nil else { return nil }
            if let some = NumberFormatter().number(from: removeInvalidChars(string!).replace(",", with: ".")) {
                return Int(truncating: some)
            }
            RJS_Logs.warning("Fail on converting [\(String(describing: string))]", tag: .rjsLib)
            return nil
        }
        
    }
}
