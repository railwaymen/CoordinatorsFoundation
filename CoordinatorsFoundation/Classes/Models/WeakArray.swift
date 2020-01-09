//
//  WeakArray.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/01/2020.
//  Copyright © 2020 Railwaymen. All rights reserved.
//

import Foundation

struct WeakArray<Element: AnyObject> {
    private var items: [WeakBox<Element>] = []
    
    var elements: [Element] {
        return self.items.compactMap { $0.value }
    }
    
    var last: Element? {
        return self.items.last { $0.value != nil }?.value
    }
    
    // MARK: - Initialization
    init() {}
    
    init(_ array: [Element]) {
        self.items = array.map { WeakBox($0) }
        self.prune()
    }
    
    // MARK: - Internal Mutating
    mutating func append(_ value: Element) {
        self.items.append(WeakBox(value))
        self.prune()
    }
    
    mutating func prune() {
        self.items.removeAll(where: { $0.value == nil })
    }
}

// MARK: - Collection
extension WeakArray: Collection {
    var startIndex: Int {
        return self.elements.startIndex
    }
    
    var endIndex: Int {
        return self.elements.endIndex
    }
    
    subscript(_ index: Int) -> Element? {
        return self.elements[safeIndex: index]
    }
    
    func index(after idx: Int) -> Int {
        return self.elements.index(after: idx)
    }
}

// MARK: - Operators
extension WeakArray {
    static func + (lhs: WeakArray, rhs: WeakArray) -> WeakArray {
        return WeakArray(lhs.elements + rhs.elements)
    }
}

// MARK: - ExpressibleByArrayLiteral
extension WeakArray: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.items = elements.map { WeakBox($0) }
        self.prune()
    }
}

// MARK: - Structures
extension WeakArray {
    private final class WeakBox<A: AnyObject> {
        weak var value: A?
        
        init(_ value: A) {
            self.value = value
        }
    }
}
