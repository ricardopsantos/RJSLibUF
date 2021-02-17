//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

// swiftlint:disable legacy_constructor

#if !os(macOS)
import Foundation
import UIKit

// MARK: - Vars

public extension RJSLibExtension where Target == UIColor {
    static var random: UIColor { UIColor.random }
    var inverse: UIColor { target.inverse }
    var uiColorStatic: UIColor { target.uiColorStatic  }
    static func colorFromHexString(_ hexString: String, alpha: Float=1.0) -> UIColor {
        UIColor.colorFromHexString(hexString, alpha: alpha)
    }
    static func colorFromRGBString(_ rgb: String) -> UIColor {
        UIColor.colorFromRGBString(rgb)
    }
}

public extension UIColor {

    var inverse: UIColor {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return .black // Return a default colour
    }

    static var random: UIColor {
        func random() -> CGFloat {
            return CGFloat(arc4random()) / CGFloat(UInt32.max)
        }
        return UIColor(red: random(), green: random(), blue: random(), alpha: 1.0)
    }

    var uiColorStatic: UIColor {
        if #available(iOS 13.0, *) {
            return self.resolvedColor(with: .current)
        } else {
            return self
        }
    }

    static func colorFromHexString(_ hexString: String, alpha: Float=1.0) -> UIColor {

        func colorComponentsFrom(_ string: String, start: Int, length: Int) -> Float {
            let subString = (string as NSString).substring(with: NSMakeRange(start, length))
            var hexValue: UInt32 = 0
            Scanner(string: subString).scanHexInt32(&hexValue)
            return Float(hexValue) / 255.0
        }

        if let cachedValue = ColorsCache.shared.get(key: hexString) as? UIColor { return cachedValue }
        let colorString = hexString.replace("#", with: "").uppercased()
        let red, blue, green: Float
        red   = colorComponentsFrom(colorString, start: 0, length: 2)
        green = colorComponentsFrom(colorString, start: 2, length: 2)
        blue  = colorComponentsFrom(colorString, start: 4, length: 2)
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        ColorsCache.shared.add(object: color, withKey: hexString)
        return color
    }
    
    static func colorFromRGBString(_ rgb: String) -> UIColor {
        guard !rgb.isEmpty else { return .black }
        
        if let cachedValue = ColorsCache.shared.get(key: rgb) as? UIColor { return cachedValue }
        
        var color: UIColor = .black
        let rgbSafe = rgb.trim.replace(";", with: ",")
        let splited = rgbSafe.split(by: ",")
        if splited.count>=3 {
            let red   = splited[0].cgFloatValue ?? 0
            let green = splited[1].cgFloatValue ?? 0
            let blue  = splited[2].cgFloatValue ?? 0
            if splited.count==4 {
                let alpha = splited[3].cgFloatValue ?? 1
                color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
                
            } else {
                color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
            }
        } else {
            return colorFromHexString(rgb)
        }
        ColorsCache.shared.add(object: color, withKey: rgb)
        return color
    }
}

public extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        let safeHex = hex.hasPrefix("#") ? hex.uppercased() : "#\(hex.uppercased())"
        let start = safeHex.index(safeHex.startIndex, offsetBy: 1)
        let hexColor = String(safeHex[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            if hexColor.count == 8 {
                a = CGFloat(hexNumber & 0x000000ff) / 255
                self.init(red: r, green: g, blue: b, alpha: a)
            } else {
                self.init(red: r, green: g, blue: b, alpha: 1)
            }
            return
        }
        return nil
    }

}

private extension UIColor {
    private struct ColorsCache {
        private init() {}
        public static let shared = ColorsCache()
        private var _cache = NSCache<NSString, AnyObject>()
        public func add(object: AnyObject, withKey: String) {
            objc_sync_enter(_cache); defer { objc_sync_exit(_cache) }
            _cache.setObject(object as AnyObject, forKey: withKey as NSString)
        }
        public func get(key: String) -> AnyObject? {
            objc_sync_enter(_cache); defer { objc_sync_exit(_cache) }
            if let object = _cache.object(forKey: key as NSString) { return object }
            return nil
        }
    }
}
#endif
