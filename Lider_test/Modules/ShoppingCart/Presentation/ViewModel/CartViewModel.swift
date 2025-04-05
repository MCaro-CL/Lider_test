//
//  CartViewModel.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation
import RxSwift

final class CartViewModel {
    private(set) var cartProducts: Set<UiProduct> = [] {
        didSet {
            if cartProducts.count != oldValue.count{
                getCartProductsNotification.onNext(())
            }
        }
    }
    private let mapper: ProductPresentationMapper
    private let getCartProductsUseCase: GetCartProductsUseCase
    private let getCartProductsNotification = PublishSubject<()>()
    var getCartProductsObservable: Observable<Void> {
        return getCartProductsNotification.asObservable()
    }
    
    private let updatePriceNotification = PublishSubject<Double>()
    var updatePriceObservable: Observable<Double> {
        return updatePriceNotification.asObservable()
    }
    
    private let addCartProductuseCase: AddToCartUseCase
    private let deleteCartProductUseCase: DeleteToCartUseCase
    private let resetProductUseCase: ResetProductUseCase
    
    init(
        mapper: ProductPresentationMapper,
        getCartProductsUseCase: GetCartProductsUseCase,
        addCartProductuseCase: AddToCartUseCase,
        deleteCartProductUseCase: DeleteToCartUseCase,
        resetProductUseCase: ResetProductUseCase
    ) {
        self.mapper = mapper
        self.getCartProductsUseCase = getCartProductsUseCase
        self.addCartProductuseCase = addCartProductuseCase
        self.deleteCartProductUseCase = deleteCartProductUseCase
        self.resetProductUseCase = resetProductUseCase
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(repostoryObserver),
                                               name: NSNotification.Name("updatedRepository"),
                                               object: nil)
    }
    
    func onViewDidAppear() {
        let products = getCartProductsUseCase.exeute()
        cartProducts = Set(products)
        updatePriceNotification.onNext(products.reduce(0) { $0 + $1.price })
    }
    func getNumberProducts() -> Int {
        cartProducts.count
    }
    func getProduct(at indexPath: IndexPath) -> UiProduct {
        let sortedProducts = Array(cartProducts)//.sorted { $0.id < $1.id }
        return sortedProducts[indexPath.row]
    }
    
    @objc
    private func repostoryObserver() {
        onViewDidAppear()
    }
    
    func addProductToCart(_ product: UiProduct) {
        addCartProductuseCase.execute(mapper.presentationToDomain(product))
        
    }
    func deleteProductFromCart(_ product: UiProduct) {
        deleteCartProductUseCase.execute(mapper.presentationToDomain(product))
    }
    func resetProductTypeFromCart(_ product: UiProduct) {
        resetProductUseCase.execute(mapper.presentationToDomain(product))
    }
    
}
