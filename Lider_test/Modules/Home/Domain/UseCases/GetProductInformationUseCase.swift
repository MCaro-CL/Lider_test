//
//  GetProductInformationUseCase.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation

struct GetProductInformationUseCase {
    private let mapper: ProductDomainMapper
    private let productRepository: ProductRepository
    
    init(mapper: ProductDomainMapper, productRepository: ProductRepository) {
        self.mapper = mapper
        self.productRepository = productRepository
    }
    
    func execute(id: Int) async -> Result<UiProduct, HTTPError> {
        switch await productRepository.getProduct(id: id) {
            case .success(let product):
                    .success(mapper.domainToPresentation(product))
            case .failure(let error):
                    .failure(error)
        }
    }
}
