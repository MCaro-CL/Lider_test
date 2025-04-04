//
//  ProductDataMapperImp.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation

struct ProductDataMapperImp: ProductDataMapper {
    func dataToDomain(_ value: ProductDTO) -> Product {
        .init(
            internalId: UUID(),
            id: value.id,
            title: value.title,
            price: value.price,
            description: value.description,
            category: value.category,
            image: value.image,
            rating: Double(value.rating.count) * value.rating.rate
        )
    }

    func dataToDomain(_ values: [ProductDTO]) -> [Product] {
        values.map {
            dataToDomain($0)
        }
    }
}
