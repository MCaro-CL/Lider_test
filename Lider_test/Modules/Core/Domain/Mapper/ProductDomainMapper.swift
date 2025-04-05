//
//  ProductDomainMapper.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation

protocol ProductDomainMapper {
    func domainToPresentation(_ value: Product) -> UiProduct
    func domainToPresentation(_ values: [Product]) -> [UiProduct]
}
