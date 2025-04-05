//
//  Array+deleterBy.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 04-04-25.
//

import Foundation

extension Array {
    mutating func delete<Value: Equatable>(by keyPath: KeyPath<Element, Value>, value: Value) {
        if let index = self.firstIndex(where: { $0[keyPath: keyPath] == value }) {
            self.remove(at: index)
        }
    }
    mutating func deleteAll<Value: Equatable>(by keyPath: KeyPath<Element, Value>, value: Value) {
            self.removeAll { element in
                element[keyPath: keyPath] == value
            }
        }
    
}
