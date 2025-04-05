    //
    //  ProductDomainMapper.swift
    //  Lider_test
    //
    //  Created by Mauricio Caro Caro on 02-04-25.
    //

import UIKit

struct ProductDomainMapperImp: ProductDomainMapper {
    func domainToPresentation(_ value: Product) -> UiProduct {
        .init(
            internalID: value.internalId,
            id: value.id,
            title: value.title,
            price: value.price,
            description: value.description,
            category: value.category,
            image: value.image,
            rating: value.rating
        )
    }
    
    func domainToPresentation(_ values: [Product]) -> [UiProduct] {
        values.map {
            domainToPresentation($0)
        }
    }
    
}

