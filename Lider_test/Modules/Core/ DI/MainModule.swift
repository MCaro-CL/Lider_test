    //
    //  MainModule.swift
    //  SmartContacts
    //
    //  Created by Mauricio Caro on 22-07-22.
    //

import Foundation
import Swinject

final class MainModule {
    private let container: Container
    
    init(_ container: Container) {
        self.container = container
    }
    
    func inject() {
        registerDataLayer()
        registerPresentationLayer()
    }
}

extension MainModule {
    private func registerDataLayer() {
            //MARK: Register Datasource
        container.register(RemoteDatasource.self) { resolve in
            RemoteDatasourceImp(
                networking: resolve.resolve(NetworkingManager.self)
            )
        }
        
            //MARK: Register HomeDataMapper
        container.register(ProductDataMapper.self) { _ in
            ProductDataMapperImp()
        }
        
            //MARK: Register repository
        container.register(ProductRepository.self) { resolve in
            ProductRepository(
                remoteDataSource: resolve.resolve(RemoteDatasource.self),
                mapper: resolve.resolve(ProductDataMapper.self)
            )
            
        }
    }
    
    private func registerPresentationLayer() {
        container.register(Coordinator.self) { _ in
            Coordinator(container: self.container)
        }
        container.register(MainTabController.self) { _ in
            MainTabController(self.container)
        }
    }
}
