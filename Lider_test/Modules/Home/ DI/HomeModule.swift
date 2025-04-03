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
        //MARK: Register Datasource
        container.register(RemoteDatasource.self) { resolve in
            RemoteDatasourceImp(
                networking: resolve.resolve(NetworkingManager.self)
            )
        }
        
        //MARK: Register HomeDataMapper
        container.register(HomeDataMapper.self) { _ in
            HomeDataMapperImp()
        }
        
        //MARK: Register repository
        container.register(HomeRepository.self) { resolve in
            HomeRepository(
                remoteDataSource: resolve.resolve(RemoteDatasource.self),
                mapper: resolve.resolve(HomeDataMapper.self)
            )
            
        }
    }
    
    private func registerDomainLayer() {
        // MARK: Register HomeDomainMapper
        container.register(HomeDomainMapper.self) { _ in
            HomeDomainMapperImp()
        }
        
        // MARK: Register Use Cases
        container.register(GetProductsUseCase.self) { resolve in
            GetProductsUseCase(
                repository: resolve.resolve(HomeRepository.self),
                mapper: resolve.resolve(HomeDomainMapper.self)
            )
        }
        
        container.register(GetCategoriesUseCase.self) { resolve in
            GetCategoriesUseCase(
                repository: resolve.resolve(HomeRepository.self)
            )
        }
        
        container.register(SelectCategoryUseCase.self) { _ in
            SelectCategoryUseCase()
        }
        
        container.register(FetchProductByCategoryUseCase.self) { resolve in
            FetchProductByCategoryUseCase(
                repository: resolve.resolve(HomeRepository.self),
                mapper: resolve.resolve(HomeDomainMapper.self)
            )
        }
    }
    
    private func registerPresentationLayer() {
        // MARK: Register ViewModels
        container.register(HomeViewModel.self) { resolve in
            HomeViewModel(
                getProductsUseCase: resolve.resolve(GetProductsUseCase.self),
                fetchProductByCategoryUseCase: resolve.resolve(FetchProductByCategoryUseCase.self)
            )
        }
        
        container.register(CategoriesViewModel.self) { resolve in
            CategoriesViewModel(
                getCategoriesUseCase: resolve.resolve(GetCategoriesUseCase.self),
                selectCategory: resolve.resolve(SelectCategoryUseCase.self)
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
    }
}
