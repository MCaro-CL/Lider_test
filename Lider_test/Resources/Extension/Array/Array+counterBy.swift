//
//  Array+counterBy.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 04-04-25.
//

import Foundation

extension Array {
    func counter<T: Hashable>(by keyPath: KeyPath<Element, T>, for value: T) -> Int {
        return self.reduce(into: 0) { count, element in
            if element[keyPath: keyPath] == value {
                count += 1
            }
        }
    }
}
