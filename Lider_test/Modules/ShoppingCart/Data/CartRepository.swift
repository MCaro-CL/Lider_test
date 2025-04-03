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
    
    private var products: [Product] = []
    
    func addProduct(_ product: Product) {
        products.append(product)
    }
    func getProducts() -> [Product] {
        return products
    }
    func deleteAllProducts() {
        products.removeAll()
    }
    func deleterProduct(at index: Int) {
        products.remove(at: index)
    }
    
}
