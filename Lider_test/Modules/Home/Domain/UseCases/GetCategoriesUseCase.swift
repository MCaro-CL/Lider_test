//
//  GetCategoriesUseCase.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation

struct GetCategoriesUseCase {
    private let repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[String], HTTPError> {
        await repository.getCategories()
    }
}
