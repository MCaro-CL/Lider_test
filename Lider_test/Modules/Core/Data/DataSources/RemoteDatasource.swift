//
//  RemoteDatasource.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation

protocol RemoteDatasource {
    func fetchProducts() async -> Result<[ProductDTO], HTTPError>
    func getCategories() async -> Result<[String], HTTPError>
    func getProducts(by category: String) async -> Result<[ProductDTO], HTTPError>
    func getProduct(id: Int) async -> Result<ProductDTO, HTTPError>
}
