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
    
    private let getProductsUseCase: GetProductsUseCase
    private let getProductsNotification = PublishSubject<Result<(),Error>>()
    public var getProductsObservable: Observable<Result<(),Error>> {
        getProductsNotification.asObservable()
    }
    
    private let fetchProductByCategoryUseCase: FetchProductByCategoryUseCase
    
    init(
        getProductsUseCase: GetProductsUseCase,
        fetchProductByCategoryUseCase: FetchProductByCategoryUseCase
    ) {
        self.getProductsUseCase = getProductsUseCase
        self.fetchProductByCategoryUseCase = fetchProductByCategoryUseCase
    }
    
    func onSetupUI() {
        Task {
            switch await getProductsUseCase.execute() {
                case .success(let products):
                    self.products = products
                    self.filterProducts = products
                        self.getProductsNotification.onNext(.success(()))

                case .failure(let error):
                        self.getProductsNotification.onNext(.failure(error))
            }
        }
    }
    
    func itemsOn(section: Int) -> Int {
        switch section {
            case 0:
                return filterProducts.count > 0 ? 1 : 0
            case 1:
                return filterProducts.count > 1 ? filterProducts.count : 0
            default:
                return 0
        }
    }
    
    func getFeaturedProduct() -> UiProduct? {
        return filterProducts.max(by: { $0.rating < $1.rating })
    }
    
    func getProduct(at: IndexPath) -> UiProduct {
        self.filterProducts[at.item]
    }
    func fetchProductsBy(category: String) {
        if category == "Todos" {
            filterProducts = products
            getProductsNotification.onNext(.success(()))
        } else {
            Task{
                switch await fetchProductByCategoryUseCase.execute(category: category) {
                    case .success(let success):
                        self.filterProducts = success
                        self.getProductsNotification.onNext(.success(()))
                    case .failure(let failure):
                        self.getProductsNotification.onNext(.failure(failure))
                }
            }
        }
    }
}
