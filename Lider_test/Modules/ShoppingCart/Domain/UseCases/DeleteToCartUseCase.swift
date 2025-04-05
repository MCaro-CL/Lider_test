//
//  DeleteToCartUseCase.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 04-04-25.
//

import Foundation

struct DeleteToCartUseCase {
    private let repository: CartRepository = CartRepository.shared
    
    init() {}
    
    func execute(_ product: Product) {
        repository.deleterProduct(product)
    }
}
