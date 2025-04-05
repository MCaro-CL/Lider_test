//
//  GetProductsUseCase.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation

struct GetProductsUseCase {
    private let repository: ProductRepository
    private let mapper: ProductDomainMapper
    
    init(repository: ProductRepository, mapper: ProductDomainMapper) {
        self.repository = repository
        self.mapper = mapper
    }
    
    func execute() async -> Result<[UiProduct], HTTPError> {
        switch await repository.fetchProducts() {
            case .success(let success):
                    .success(mapper.domainToPresentation(success))
            case .failure(let failure):
                    .failure(failure)
        }
    }
}
