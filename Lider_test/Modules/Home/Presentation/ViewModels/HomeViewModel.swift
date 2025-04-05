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
    
    private let mapper: ProductPresentationMapper
    private let getProductsUseCase: GetProductsUseCase
    private let getProductsNotification = PublishSubject<Result<(),Error>>()
    public var getProductsObservable: Observable<Result<(),Error>> {
        getProductsNotification.asObservable()
    }
    
    private let fetchProductByCategoryUseCase: FetchProductByCategoryUseCase
    private let addCartProductuseCase: AddToCartUseCase
    
    init(
        mapper: ProductPresentationMapper,
        getProductsUseCase: GetProductsUseCase,
        fetchProductByCategoryUseCase: FetchProductByCategoryUseCase,
        addCartProductuseCase: AddToCartUseCase
    ) {
        self.mapper = mapper
        self.getProductsUseCase = getProductsUseCase
        self.fetchProductByCategoryUseCase = fetchProductByCategoryUseCase
        self.addCartProductuseCase = addCartProductuseCase
    }
    
    func onSetupUI() {
        Task {
            switch await getProductsUseCase.execute() {
                case .success(let products):
                    self.products = products
                        self.getProductsNotification.onNext(.success(()))

                case .failure(let error):
                        self.getProductsNotification.onNext(.failure(error))
            }
        }
    }
    
    func addProductToCart(_ product: UiProduct) {
        addCartProductuseCase.execute(mapper.presentationToDomain(product))
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
    func fetchProductsBy(category: String) {
        if category == "Todos" {
            self.onSetupUI()
        } else {
            Task{
                switch await fetchProductByCategoryUseCase.execute(category: category) {
                    case .success(let success):
                        self.products = success
                        self.getProductsNotification.onNext(.success(()))
                    case .failure(let failure):
                        self.getProductsNotification.onNext(.failure(failure))
                }
            }
        }
    }
}
