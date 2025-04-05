//
//  UiProduct.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import UIKit

struct UiProduct: Hashable {
    let internalID: UUID
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: String
    var rating: Double
}
