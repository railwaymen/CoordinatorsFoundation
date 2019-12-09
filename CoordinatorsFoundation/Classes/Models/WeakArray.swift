//
//  WeakArray.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/12/2019.
//

import Foundation

struct WeakArray<Element: AnyObject> {
    private var items: [WeakBox<Element>] = []
    
    var elements: [Element] {
        return self.items.compactMap { $0.value }
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
    
    mutating func remove(_ value: Element) {
        self.items.removeAll { $0 === value }
        self.prune()
    }
    
    mutating func prune() {
        self.items = self.items.filter { $0.value != nil }
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

// MARK: - Structures
extension WeakArray {
    private final class WeakBox<A: AnyObject> {
        weak var value: A?
        
        init(_ value: A) {
            self.value = value
        }
    }
}
