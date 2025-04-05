//
//  CartModule.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation
import Swinject

final class CartModule {
    private let container: Container
    
    init(_ container: Container) {
        self.container = container
    }
    
    func inject() {
        registerDataLayer()
        registerDomainLayer()
        registerPresentationLayer()
    }
}

extension CartModule {
    private func registerDataLayer() {}
    private func registerDomainLayer() {
        container.register(GetCartProductsUseCase.self) { resolve in
            GetCartProductsUseCase(
                mapper: resolve.resolve(ProductDomainMapper.self)
            )
        }
        container.register(AddToCartUseCase.self) { _ in
            AddToCartUseCase()
        }
        container.register(DeleteToCartUseCase.self) { _ in
            DeleteToCartUseCase()
        }
        container.register(ResetProductUseCase.self) { _ in
            ResetProductUseCase()
        }
        
    }
    private func registerPresentationLayer() {
        container.register(CartViewModel.self) { resolve in
            CartViewModel(
                mapper: resolve.resolve(ProductPresentationMapper.self),
                getCartProductsUseCase: resolve.resolve(GetCartProductsUseCase.self),
                addCartProductuseCase: resolve.resolve(AddToCartUseCase.self),
                deleteCartProductUseCase: resolve.resolve(DeleteToCartUseCase.self),
                resetProductUseCase: resolve.resolve(ResetProductUseCase.self)
            )
        }
        container.register(CartViewController.self) { resolve in
            CartViewController(
                viewModel: resolve.resolve(CartViewModel.self),
                coordinator: resolve.resolve(Coordinator.self)
            )
        }
    }
}
