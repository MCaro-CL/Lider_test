//
//  GetCartProductsUseCase.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 04-04-25.
//

import Foundation

struct GetCartProductsUseCase {
    private let repository: CartRepository = CartRepository.shared
    private let mapper: ProductDomainMapper
    
    init (mapper: ProductDomainMapper) {
        self.mapper = mapper
    }
    
    func exeute() -> [UiProduct] {
        mapper.domainToPresentation(repository.getProducts())
    }
}
