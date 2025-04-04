//
//  ProductDataMapper.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation

protocol ProductDataMapper {
    func dataToDomain(_ value: ProductDTO) -> Product
    func dataToDomain(_ values: [ProductDTO]) -> [Product]
}
