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
    private func registerDataLayer() {
        
    }
    private func registerDomainLayer() {
        
    }
    private func registerPresentationLayer() {
        container.register(CartViewModel.self) { _ in
            CartViewModel()
        }
        container.register(CartViewController.self) { resolve in
            CartViewController(
                viewModel: resolve.resolve(CartViewModel.self),
                coordinator: resolve.resolve(Coordinator.self)
            )
        }
    }
}
