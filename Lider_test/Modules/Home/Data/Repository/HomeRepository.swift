//
//  HomeRepository.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation

struct HomeRepository: HomeDatasource {
    private let remoteDataSource: RemoteDatasource
    private let mapper: HomeDataMapper
    
    init(remoteDataSource: RemoteDatasource, mapper: HomeDataMapper) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }
    
    func fetchProducts() async -> Result<[Product], HTTPError> {
        (await remoteDataSource.fetchProducts()).map { mapper.dataToDomain($0) }
    }

    func getCategories() async -> Result<[String], HTTPError> {
        await remoteDataSource.getCategories() 
    }

    func getProducts(by category: String) async -> Result<[Product], HTTPError> {
        switch await remoteDataSource.getProducts(by: category) {
                case .success(let data):
                return .success(mapper.dataToDomain(data))
                
            case .failure(let error):
                return .failure(error)
        }
    }

    func getProduct(id: Int) async -> Result<Product, HTTPError> {
        (await remoteDataSource.getProduct(id: id )).map { mapper.dataToDomain($0)
        }
    }
}
