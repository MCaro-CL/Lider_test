//
//  AddToCartUseCase.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation

struct AddToCartUseCase {
    private let repository: CartRepository = CartRepository.shared
    
    init() {}
    
    func execute(_ product: Product) {
        repository.addProduct(product)
    }
}
