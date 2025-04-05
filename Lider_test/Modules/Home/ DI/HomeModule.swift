//
//  HomeModule.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//

import Foundation
import Swinject

final class HomeModule {
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

extension HomeModule {
    private func registerDataLayer() {
        
    }
    
    private func registerDomainLayer() {
        // MARK: Register HomeDomainMapper
        
        
        // MARK: Register Use Cases
        container.register(GetProductsUseCase.self) { resolve in
            GetProductsUseCase(
                repository: resolve.resolve(ProductRepository.self),
                mapper: resolve.resolve(ProductDomainMapper.self)
            )
        }
        
        container.register(GetCategoriesUseCase.self) { resolve in
            GetCategoriesUseCase(
                repository: resolve.resolve(ProductRepository.self)
            )
        }
        
        container.register(FetchProductByCategoryUseCase.self) { resolve in
            FetchProductByCategoryUseCase(
                repository: resolve.resolve(ProductRepository.self),
                mapper: resolve.resolve(ProductDomainMapper.self)
            )
        }
        container.register(GetProductInformationUseCase.self) { resolve in
            GetProductInformationUseCase(
                mapper: resolve.resolve(ProductDomainMapper.self),
                productRepository: resolve.resolve(ProductRepository.self)
            )
        }
    }
    
    private func registerPresentationLayer() {
        // MARK: Register ViewModels
        container.register(HomeViewModel.self) { resolve in
            HomeViewModel(
                mapper: resolve.resolve(ProductPresentationMapper.self),
                getProductsUseCase: resolve.resolve(GetProductsUseCase.self),
                fetchProductByCategoryUseCase: resolve.resolve(FetchProductByCategoryUseCase.self),
                addCartProductuseCase: resolve.resolve(AddToCartUseCase.self)
            )
        }
        
        container.register(CategoriesViewModel.self) { resolve in
            CategoriesViewModel(
                getCategoriesUseCase: resolve.resolve(GetCategoriesUseCase.self)
            )
        }
        container.register(ProductDetailViewModel.self) { resolve in
            ProductDetailViewModel(
                mapper: resolve.resolve(ProductPresentationMapper.self),
                getProductInformationUseCase: resolve.resolve(GetProductInformationUseCase.self),
                addToCartUseCase: resolve.resolve(AddToCartUseCase.self)
            )
        }
        
        // MARK: Register ViewControllers
        container.register(HomeViewController.self) { resolve in
            HomeViewController(
                viewModel: resolve.resolve(HomeViewModel.self),
                coordinator: resolve.resolve(Coordinator.self)
            )
        }
        
        container.register(CategoriesViewController.self) { resolve in
            CategoriesViewController(
                viewModel: resolve.resolve(CategoriesViewModel.self),
                coordinator: resolve.resolve(Coordinator.self)
            )
        }
        container.register(ProductDetailViewController.self) {resolve, argument in
            ProductDetailViewController(
                productId: argument,
                viewModel: resolve.resolve(ProductDetailViewModel.self),
                coordinator: resolve.resolve(Coordinator.self)
            )
        }
    }
}
