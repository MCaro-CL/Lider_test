//
//  HomeViewModel.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation
import RxSwift


final class HomeViewModel {
    private(set) var products: [UiProduct] = []
    private(set) var filterProducts: [UiProduct] = []
    
    private let fetchProductsUseCase: FetchProductsUseCase
    private let fetchProductsNotification = PublishSubject<Result<(),Error>>()
    public var fetchProductsObservable: Observable<Result<(),Error>> {
        fetchProductsNotification.asObservable()
    }
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func onSetupUI() {
        Task {
            switch await fetchProductsUseCase.execute() {
                case .success(let products):
                    self.products = products
                    self.filterProducts = products
                        self.fetchProductsNotification.onNext(.success(()))

                case .failure(let error):
                        self.fetchProductsNotification.onNext(.failure(error))
            }
        }
    }
    
    func itemsOn(section: Int) -> Int {
        switch section {
            case 0:
                return products.count > 0 ? 1 : 0
            case 1:
                return products.count > 1 ? products.count : 0
            default:
                return 0
        }
    }
    
    func getFeaturedProduct() -> UiProduct? {
        return products.max(by: { $0.rating < $1.rating })
    }
    
    func getProduct(at: IndexPath) -> UiProduct {
        self.products[at.item]
    }
}
