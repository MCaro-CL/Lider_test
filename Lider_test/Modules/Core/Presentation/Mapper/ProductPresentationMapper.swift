//
//  ProductPresentationMapper.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 04-04-25.
//

import Foundation

protocol ProductPresentationMapper {
    func presentationToDomain(_ value: UiProduct) -> Product
    func presentationToDomain(_ values: [UiProduct]) -> [Product]
}
