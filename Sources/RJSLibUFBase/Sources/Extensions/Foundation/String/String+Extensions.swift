//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
#if !os(macOS)
import UIKit
#endif
import CommonCrypto

public extension RJSLibExtension where Target == String {
    var length: Int { target.length }
    var first: String { target.first  }
    var last: String { target.last }
    var trim: String { target.trim }
    var trimmedAndSingleSpaced: String { target.trimmedAndSingleSpaced }
    
    var capitalised: String { target.capitalised }
    var encodedUrl: String? { target.encodedUrl }
    var decodedUrl: String? { target.decodedUrl }
    var reversed: String { target.reversed }
    var base64Encoded: String { target.base64Encoded }
    var base64Decoded: String? { target.base64Decoded }
    
    var utf8Data: Data? { target.utf8Data }
    var cgFloatValue: CGFloat? { target.cgFloatValue }
    var boolValue: Bool? { target.boolValue }
    var doubleValue: Double? { target.doubleValue }
    var intValue: Int? { target.intValue }
    var dateValue: Date? { target.dateValue }
    var floatValue: Float? { target.floatValue }
    var decimalValue: Decimal? { target.decimalValue }
    
    var deterministicHashValue: Int { target.deterministicHashValue }
    var sha1: String { target.sha1 }
    var isValidEmail: Bool { target.isValidEmail }
    var isAlphanumeric: Bool { target.isAlphanumeric }
    var containsOnlyDigits: Bool { target.containsOnlyDigits }
    func contains(subString: String, ignoreCase: Bool=true) -> Bool {
        target.contains(subString: subString, ignoreCase: ignoreCase)
    }
    
    var asDict: [String: Any]? { target.asDict }
    var asAttributedString: NSAttributedString? { target.asAttributedString }
    
    #if !os(macOS)
    func image(font: UIFont, size: CGSize = CGSize(width: 40, height: 40)) -> UIImage? {
        target.image(font: font, size: size)
    }
    #endif
    
    func split(by: String) -> [String] { target.split(by: by) }
    static func random(_ length: Int) -> String { String.random(length) }
    
    func replace(_ some: String, with: String) -> String {
        target.replace(some, with: with)
    }
    
    #if !os(macOS)
    func htmlAttributedString(fontName: String, fontSize: Int, colorHex: String) -> NSAttributedString? {
        target.htmlAttributedString(fontName: fontName, fontSize: fontSize, colorHex: colorHex)
    }
    #endif
    
}

//
// MARK: - Transformations / Operators
//

public extension String {
    
    var length: Int { return self.count }
    var first: String { return String(self.prefix(1)) }
    var last: String { if self.count == 0 { return "" } else { return String(self.suffix(1))} }
    var trim: String { return self.trimmingCharacters(in: .whitespacesAndNewlines) }
    var trimmedAndSingleSpaced: String { return replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression).trim }
    
    var capitalised: String { self.count >= 1 ? prefix(1).uppercased() + self.lowercased().dropFirst() : "" }
    var encodedUrl: String? { self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) }
    var decodedUrl: String? { self.removingPercentEncoding }
    var reversed: String { var acc = ""; for char in self { acc = "\(char)\(acc)" }; return acc }
    var base64Encoded: String { RJS_Convert.Base64.toB64String(self as AnyObject) ?? ""}
    var base64Decoded: String? { RJS_Convert.Base64.toPlainString(self) }
    
    var utf8Data: Data? { self.data(using: .utf8) }
    var cgFloatValue: CGFloat? { RJS_Convert.toCGFloat(self) }
    var boolValue: Bool? { RJS_Convert.toBool(self) }
    var doubleValue: Double? { RJS_Convert.toDouble(self) }
    var intValue: Int? { RJS_Convert.toInt(self) }
    var dateValue: Date? { RJS_Convert.toDate("\(self)" as AnyObject) }
    var floatValue: Float? { floatValueA }
    var decimalValue: Decimal? {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let groupingSeparator = Locale.current.groupingSeparator ?? ","
        let regex: NSRegularExpression! = try? NSRegularExpression(pattern: "[^0-9\(decimalSeparator)]", options: .caseInsensitive)
        var formatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.decimalSeparator = decimalSeparator
            formatter.groupingSeparator = groupingSeparator
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter
        }

        let regexedString = regex.stringByReplacingMatches(in: self,
                                                           options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                           range: NSRange(location: 0, length: self.count),
                                                           withTemplate: "")

        return formatter.number(from: regexedString)?.decimalValue
    }
    
    private var floatValueA: Float? { RJS_Convert.toFloat(self) }
    private var floatValueB: CGFloat { CGFloat((self as NSString).floatValue) }
    
}

//
// MARK: - Hashing
//

public extension String {
    
     var deterministicHashValue: Int {
         return zip(utf8.map(numericCast), Swift.sequence(first: 1, next: { $0 &* 589836 })).map(&*).reduce(0, &+)
     }

     var sha1: String {
         let data = Data(self.utf8)
         var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
         data.withUnsafeBytes {
             _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
         }
         let hexBytes = digest.map { String(format: "%02hhx", $0) }
         return hexBytes.joined()
     }
}

//
// MARK: - Constructors
//

public extension String {
    init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}

//
// MARK: - Bools
//

public extension String {
    
    //Found at https://medium.com/@darthpelo/email-validation-in-swift-3-0-acfebe4d879a
    var isValidEmail: Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isAlphanumeric: Bool {
        !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var containsOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    func contains(subString: String, ignoreCase: Bool=true) -> Bool {
        if ignoreCase {
            return self.lowercased().range(of: subString.lowercased()) != nil
        } else {
            return self.range(of: subString) != nil
        }
    }
}

//
// MARK: - Utils
//

public extension CustomStringConvertible where Self: Codable {
    var description: String {
        var description = "\n \(type(of: self)) \n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}

public extension String {
    
    // let json = "{\"hello\": \"world\"}"
    // let dictFromJson = json.asDict
    var asDict: [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }

    // let htmlString = "<p>Hello, <strong>world!</string></p>"
    // let attrString = htmlString.asAttributedString
    var asAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
    
    #if !os(macOS)
    func image(font: UIFont, size: CGSize = CGSize(width: 40, height: 40)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: font])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    #endif
    
    func split(by: String) -> [String] {
        guard !by.isEmpty else { return [] }
        return self.components(separatedBy: by.first)
    }

    static func random(_ length: Int) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    func replace(_ some: String, with: String) -> String {
        guard !some.isEmpty else { return self }
        return self.replacingOccurrences(of: some, with: with)
    }
    
    #if !os(macOS)
    func htmlAttributedString(fontName: String, fontSize: Int, colorHex: String) -> NSAttributedString? {
        do {
            let cssPrefix = "<style>* { font-family: \(fontName); color: #\(colorHex); font-size: \(fontSize); }</style>"
            let html = cssPrefix + self
            guard let data = html.data(using: String.Encoding.utf8) else {  return nil }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            RJS_Logs.error("\(error)", tag: .rjsLib)
            return nil
        }
        /*
         let test = {
         let html = "<strong>Dear Friend</strong> I hope this <i>tip</i> will be useful for <b>you</b>."
         let attributedString = html.htmlAttributedString(with: "Futura", fontSize: 14, colorHex: "ff0000")
         
         }
         test()*/
    }
    #endif
}

//
// MARK: - SubScript
//

public extension String {

    subscript (i: Int) -> String { return self[i ..< i + 1] }

    func substring(fromIndex: Int) -> String { return self[min(fromIndex, length) ..< length] }

    func substring(toIndex: Int) -> String { return self[0 ..< max(0, toIndex)] }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start..<end]
    }

    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start...end]
    }

    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        if end < start { return "" }
        return self[start...end]
    }

    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex...end]
    }

    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex..<end]
    }

}
