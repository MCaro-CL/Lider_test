//
//  ProductPresentationMapperImp.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 04-04-25.
//

import Foundation

struct ProductPresentationMapperImp: ProductPresentationMapper {
    func presentationToDomain(_ value: UiProduct) -> Product {
        .init(
            internalId: value.internalID,
            id: value.id,
            title: value.title,
            price: value.price,
            description: value.description,
            category: value.category,
            image: value.image,
            rating: value.rating
        )
    }

    func presentationToDomain(_ values: [UiProduct]) -> [Product] {
        values.map {
            presentationToDomain($0)
        }
    }

    
}
