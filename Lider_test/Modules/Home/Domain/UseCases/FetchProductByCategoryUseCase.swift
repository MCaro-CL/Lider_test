//
//  FetchProductByCategoryUseCase.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation

struct FetchProductByCategoryUseCase {
    private let repository: HomeRepository
    private let mapper: HomeDomainMapper
    
    init(repository: HomeRepository, mapper: HomeDomainMapper) {
        self.repository = repository
        self.mapper = mapper
    }
    
    func execute(category: String) async  -> Result<[UiProduct], HTTPError> {
        switch await repository.getProducts(by: category) {
            case .success(let success):
                    return .success(mapper.domainToPresentation(success))
            case .failure(let failure):
                    return .failure(failure)
        }
    }
}
