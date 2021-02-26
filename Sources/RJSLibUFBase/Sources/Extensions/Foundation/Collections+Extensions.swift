//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
#if !os(macOS)
import UIKit
#endif

public extension Array {
    
    mutating func shuffle() {
        for _ in 0...self.count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
    
    private func safeItem(at index: Int) -> Element? {
        Int(index) < count ? self[Int(index)] : nil
    }
    
    // Safe get item at index
    func item(at index: Int) -> Element? {
        safeItem(at: index)
    }
    
    func element(at index: Int) -> Element? {
        safeItem(at: index)
    }
    
    #if !os(macOS)
    subscript(indexPath: IndexPath) -> Element? {
        safeItem(at: indexPath.row)
    }
    #endif
    
    func take(_ k: Int) -> Array {
        let min = Swift.min(k, count)
        return Array(self[0..<min])
    }

    func skip(_ k: Int) -> Array {
        return Array(dropFirst(k))
    }
    
    var randomItem: Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

public extension Array where Element: Hashable {
    /// Taken from here: https://stackoverflow.com/a/46354989/491239
    static func removeDuplicates(_ elements: [Element]) -> [Element] {
        var seen = Set<Element>()
        return elements.filter { seen.insert($0).inserted }
    }
}

public extension RangeReplaceableCollection where Iterator.Element: Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(_ object: Iterator.Element) {
        self = self.filter { return $0 != object }
    }
}
