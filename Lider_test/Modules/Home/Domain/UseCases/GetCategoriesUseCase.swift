//
//  GetCategoriesUseCase.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation

struct GetCategoriesUseCase {
    private let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[String], HTTPError> {
        await repository.getCategories()
    }
}
