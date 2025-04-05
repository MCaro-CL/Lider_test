//
//  ProductDetailViewModel.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation
import RxSwift
import UIKit

struct ProductDetailViewModel {
    private let mapper: ProductPresentationMapper
    
    private let getProductInformationUseCase: GetProductInformationUseCase
    private let getProductInformationNotification = PublishSubject<Result<UiProduct, HTTPError>>()
    var getProductInformationObservable: Observable<Result<UiProduct, HTTPError>> {
        return getProductInformationNotification.asObservable()
    }
    
    private let addToCartUseCase: AddToCartUseCase
    private let addToCartNotification = PublishSubject<()>()
    var addToCartObservable: Observable<()> {
        return addToCartNotification.asObservable()
    }
    
    init(
        mapper: ProductPresentationMapper,
        getProductInformationUseCase: GetProductInformationUseCase,
        addToCartUseCase: AddToCartUseCase
    ) {
        self.mapper = mapper
        self.getProductInformationUseCase = getProductInformationUseCase
        self.addToCartUseCase = addToCartUseCase
    }
    
    func onSetupUI(id: Int) {
        Task{
            switch await getProductInformationUseCase.execute(id: id) {
                case .success(let product):
                    getProductInformationNotification.onNext(.success(product))
                    
                case.failure(let error):
                    getProductInformationNotification.onNext(.failure(error))
            }
        }
    }
    
    func didTapOnAddToCartButton(_ product: UiProduct?) {
        if let product {
            addToCartUseCase.execute(mapper.presentationToDomain(product))
        }
        addToCartNotification.onNext(())
    }
}
