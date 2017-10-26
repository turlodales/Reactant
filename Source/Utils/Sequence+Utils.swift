//
//  Sequence+Utils.swift
//  Reactant
//
//  Created by Filip Dolnik on 21.02.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Foundation

extension Sequence {
    
    public func take(until: (Iterator.Element) -> Bool) -> [Iterator.Element] {
        var result: [Iterator.Element] = []
        for item in self {
            guard until(item) else { break }
            result.append(item)
        }
        return result
    }
    
    public func first(where condition: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for item in self where condition(item) {
            return item
        }
        return nil
    }
    
    public func all(predicate: (Iterator.Element) -> Bool) -> Bool {
        for element in self where !predicate(element) {
            return false
        }
        return true
    }
    
    public func any(predicate: (Iterator.Element) -> Bool) -> Bool {
        return first(where: predicate) != nil
    }
    
    public func distinct(where comparator: (_ lhs: Iterator.Element, _ rhs: Iterator.Element) -> Bool) -> [Iterator.Element] {
        var result: [Iterator.Element] = []
        for item in self where result.contains(where: { comparator(item, $0) }) == false {
            result.append(item)
        }
        return result
    }
}

extension Sequence where Iterator.Element: Equatable {
    
    public func distinct() -> [Iterator.Element] {
        return distinct(where: ==)
    }
}

extension Sequence where Iterator.Element: Hashable {

    /**
     * Returns an array with duplicates removed, keeping the first element it reaches and discarding others that are equal to it.
     * - complexity: This method uses a set making this algorithm O(n).
     * - returns: array with only distinct elements, honoring position of each element
     */
    public func distinct() -> [Iterator.Element] {
        var set = [] as Set<Iterator.Element>
        var result = [] as [Iterator.Element]

        for element in self where !set.contains(element) {
            set.insert(element)
            result.append(element)
        }

        return result
    }
}
