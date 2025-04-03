//
//  RemoteDatasourceImp.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation

struct RemoteDatasourceImp: RemoteDatasource {
    private let baseURL: String = "https://fakestoreapi.com"
    private let networking: NetworkingManager
    
    init(networking: NetworkingManager) {
        self.networking = networking
    }
    
    func fetchProducts() async -> Result<[ProductDTO], HTTPError> {
        let request = APIRequest(
            baseUrl: baseURL + "/products",
            method: .get,
            responseType: [ProductDTO].self
        )
        switch await networking.download(request) {
            case .success(let response):
                guard let products = response.value else {
                    return .failure(.invalidResponse(response.rawValue?.toString() ?? ""))
                }
                return .success(products)
                
            case .failure(let error):
                return .failure(error)
        }
    }

    func getCategories() async -> Result<[String], HTTPError> {
        let request = APIRequest(
            baseUrl: baseURL + "/products/categories",
            method: .get,
            responseType: [String].self
        )
        switch await networking.download(request) {
            case .success(let response):
                guard let categories = response.value else {
                    return .failure(.invalidResponse(response.rawValue?.toString() ?? ""))
                }
                return .success(categories)
                
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func getProducts(by category: String) async -> Result<[ProductDTO], HTTPError> {
        let request = APIRequest(
            baseUrl: baseURL + "/products/categories/\(category)",
            method: .get,
            responseType: [ProductDTO].self
        )
        switch await networking.download(request) {
            case .success(let response):
                guard let products = response.value else {
                    return .failure(.invalidResponse(response.rawValue?.toString() ?? ""))
                }
                return .success(products)
                
            case .failure(let error):
                return .failure(error)
        }
    }

    func getProduct(id: Int) async -> Result<ProductDTO, HTTPError> {
        let request = APIRequest(
            baseUrl: baseURL + "/products/\(id)",
            method: .get,
            responseType: ProductDTO.self
        )
        switch await networking.download(request) {
            case .success(let response):
                guard let product = response.value else {
                    return .failure(.invalidResponse(response.rawValue?.toString() ?? ""))
                }
                return .success(product)
                
            case .failure(let error):
                return .failure(error)
        }
    }
}
