//
//  CartRepository.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation

final class CartRepository {
    private static let _shared = CartRepository()
    public static var shared: CartRepository { _shared }
    
    private var products: [Product] = [] {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("updatedRepository"), object: self.products.count)
        }
    }
    func getProducts() -> [Product] {
        return products
    }
    
    func addProduct(_ product: Product) {
        products.append(product)
    }
    
    func deleterProduct(_ product: Product) {
        products.delete(by: \.internalId, value: product.internalId)
    }
    func counterBy(id: Int) -> Int {
        return products.counter(by: \.id, for: id)
    }
    func resetProductBy(id: Int) {
        products.deleteAll(by: \.id, value: id)
    }
}
