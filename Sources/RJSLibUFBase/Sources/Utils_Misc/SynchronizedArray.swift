//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
#if !os(macOS)
    import UIKit
#endif

// swiftlint:disable all

//
// http://basememara.com/creating-thread-safe-arrays-in-swift/
// https://gist.github.com/basememara/afaae5310a6a6b97bdcdbe4c2fdcd0c6
// https://sachithrasiriwardhane.medium.com/thread-safe-singletons-and-their-usage-in-swift-c992d34d85dd
//

/*
 private static var _beaconsInRange = SynchronizedArray<CLBeacon>()
 static var beaconsInRange : SynchronizedArray<CLBeacon> {
 get { return _beaconsInRange }
 set(newValue) { _beaconsInRange = newValue }
 }
 */

/// A thread-safe array.
public class SynchronizedArray<Element> {
    fileprivate let queue = DispatchQueue(label: "rjpsLib.SynchronizedArray", attributes: .concurrent)
    fileprivate var array = [Element]()
}

// MARK: - Properties
public extension SynchronizedArray {
    
    /// The first element of the collection.
    var first: Element? {
        var result: Element?
        queue.sync { [weak self] in result = self?.array.first }
        return result
    }
    
    /// The last element of the collection.
    var last: Element? {
        var result: Element?
        queue.sync { [weak self] in result = self?.array.last }
        return result
    }
    
    /// The number of elements in the array.
    var count: Int {
        var result = 0
        queue.sync { [weak self] in result = self?.array.count ?? 0 }
        return result
    }
    
    /// A Boolean value indicating whether the collection is empty.
    var isEmpty: Bool {
        var result = false
        queue.sync { [weak self] in result = self?.array.isEmpty ?? true }
        return result
    }
    
    /// A textual representation of the array and its elements.
    var description: String {
        var result = ""
        queue.sync { [weak self] in result = self?.array.description ?? "" }
        return result
    }
}

// MARK: - Immutable
public extension SynchronizedArray {
    /*
     // Remove first collection element that is equal to the given `object`:
     func removeObject(_ object : Element) {
     var result: Element?
     queue.sync { result = self.filter { return $0 != object } }
     return result
     //self = self.filter { return $0 != object }
     }
     */
    /// Returns the first element of the sequence that satisfies the given predicate or nil if no such element is found.
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
    /// - Returns: The first match or nil if there was no match.
    func first(where predicate: (Element) -> Bool) -> Element? {
        var result: Element?
        queue.sync { [weak self] in result = self?.array.first(where: predicate) }
        return result
    }
    
    /// Returns an array containing, in order, the elements of the sequence that satisfy the given predicate.
    ///
    /// - Parameter isIncluded: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element should be included in the returned array.
    /// - Returns: An array of the elements that includeElement allowed.
    func filter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result = [Element]()
        queue.sync { [weak self] in result = self?.array.filter(isIncluded) ?? [] }
        return result
    }
    
    func filter2(_ isIncluded: (Element) -> Bool) {
        queue.sync { [weak self] in
            self?.array.removeAll()
            self?.array = self?.array.filter(isIncluded) ?? []
        }
    }
    
    /// Returns the first index in which an element of the collection satisfies the given predicate.
    ///
    /// - Parameter predicate: A closure that takes an element as its argument and returns a Boolean value that indicates whether the passed element represents a match.
    /// - Returns: The index of the first element for which predicate returns true. If no elements in the collection satisfy the given predicate, returns nil.
    func index(where predicate: (Element) -> Bool) -> Int? {
        var result: Int?
        queue.sync { [weak self] in result = self?.array.firstIndex(where: predicate) }
        return result
    }
    
    /// Returns the elements of the collection, sorted using the given predicate as the comparison between elements.
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns true if its first argument should be ordered before its second argument; otherwise, false.
    /// - Returns: A sorted array of the collection’s elements.
    func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
        var result = [Element]()
        queue.sync { [weak self] in result = self?.array.sorted(by: areInIncreasingOrder) ?? [] }
        return result
    }
    
    /// Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.
    ///
    /// - Parameter transform: A closure that accepts an element of this sequence as its argument and returns an optional value.
    /// - Returns: An array of the non-nil results of calling transform with each element of the sequence.
    func flatMap<ElementOfResult>(_ transform: (Element) -> ElementOfResult?) -> [ElementOfResult] {
        var result = [ElementOfResult]()
        queue.sync { [weak self] in result = self?.array.compactMap(transform) ?? [] }
        return result
    }
    
    /// Calls the given closure on each element in the sequence in the same order as a for-in loop.
    ///
    /// - Parameter body: A closure that takes an element of the sequence as a parameter.
    func forEach(_ body: (Element) -> Void) {
        queue.sync { [weak self] in self?.array.forEach(body) }
    }
    
    /// Returns a Boolean value indicating whether the sequence contains an element that satisfies the given predicate.
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element represents a match.
    /// - Returns: true if the sequence contains an element that satisfies predicate; otherwise, false.
    func contains(where predicate: (Element) -> Bool) -> Bool {
        var result = false
        queue.sync { [weak self] in result = self?.array.contains(where: predicate) ?? false }
        return result
    }
}

// MARK: - Mutable
public extension SynchronizedArray {
    
    /// Adds a new element at the end of the array.
    ///
    /// - Parameter element: The element to append to the array.
    func append( _ element: Element) {
        queue.async(flags: .barrier) { [weak self] in
            self?.array.append(element)
        }
    }
    
    /// Adds a new element at the end of the array.
    ///
    /// - Parameter element: The element to append to the array.
    func append( _ elements: [Element]) {
        queue.async(flags: .barrier) { [weak self] in
            self?.array += elements
        }
    }
    
    /// Inserts a new element at the specified position.
    ///
    /// - Parameters:
    ///   - element: The new element to insert into the array.
    ///   - index: The position at which to insert the new element.
    func insert( _ element: Element, at index: Int) {
        queue.async(flags: .barrier) { [weak self] in
            self?.array.insert(element, at: index)
        }
    }
    
    /// Removes and returns the element at the specified position.
    ///
    /// - Parameters:
    ///   - index: The position of the element to remove.
    ///   - completion: The handler with the removed element.
    func remove(at index: Int, completion: ((Element) -> Void)? = nil) {
        queue.async(flags: .barrier) { [weak self] in
            let element = self?.array.remove(at: index)
            guard element != nil else { return }
            DispatchQueue.main.async {
                completion?(element!)
            }
        }
    }
    
    /// Removes and returns the element at the specified position.
    ///
    /// - Parameters:
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
    ///   - completion: The handler with the removed element.
    func remove(where predicate: @escaping (Element) -> Bool, completion: ((Element) -> Void)? = nil) {
        queue.async(flags: .barrier) { [weak self] in
            guard let index = self?.array.firstIndex(where: predicate) else { return }
            let element = self?.array.remove(at: index)
            guard element != nil else { return }
            DispatchQueue.main.async {
                completion?(element!)
            }
        }
    }
    
    /// Removes all elements from the array.
    ///
    /// - Parameter completion: The handler with the removed elements.
    func removeAll(completion: (([Element]) -> Void)? = nil) {
        queue.async(flags: .barrier) { [weak self] in
            let elements = self?.array ?? []
            self?.array.removeAll()
            
            DispatchQueue.main.async {
                completion?(elements)
            }
        }
    }
}

public extension SynchronizedArray {
    
    /// Accesses the element at the specified position if it exists.
    ///
    /// - Parameter index: The position of the element to access.
    /// - Returns: optional element if it exists.
    subscript(index: Int) -> Element? {
        get {
            var result: Element?
            
            queue.sync { [weak self] in
                guard let self = self else { return }
                guard self.array.startIndex..<self.array.endIndex ~= index else { return }
                result = self.array[index]
            }
            
            return result
        }
        set {
            guard let newValue = newValue else { return }
            queue.async(flags: .barrier) { [weak self] in
                self?.array[index] = newValue
            }
        }
    }
}

// MARK: - Equatable
public extension SynchronizedArray where Element: Equatable {
    
    /// Returns a Boolean value indicating whether the sequence contains the given element.
    ///
    /// - Parameter element: The element to find in the sequence.
    /// - Returns: true if the element was found in the sequence; otherwise, false.
    func contains(_ element: Element) -> Bool {
        var result = false
        queue.sync { [weak self] in result = self?.array.contains(element) ?? false }
        return result
    }
}

// MARK: - Infix operators
public extension SynchronizedArray {
    
    static func += (left: inout SynchronizedArray, right: Element) {
        left.append(right)
    }
    
    static func += (left: inout SynchronizedArray, right: [Element]) {
        left.append(right)
    }
}
