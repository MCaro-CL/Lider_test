//
//  HomeDatasource.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation

protocol HomeDatasource {
    func fetchProducts() async -> Result<[Product], HTTPError>
    func getCategories() async -> Result<[String], HTTPError>
    func getProducts(by category: String) async -> Result<[Product], HTTPError>
    func getProduct(id: Int) async -> Result<Product, HTTPError>
}
