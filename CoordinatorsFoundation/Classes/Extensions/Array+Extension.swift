//
//  Array+Extensin.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/12/2019.
//

import Foundation

extension Array {
    subscript(safeIndex index: Index) -> Element? {
        return (self.startIndex..<self.endIndex).contains(index) ? self[index] : nil
    }
}
