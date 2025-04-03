//
//  NetworkingModule.swift
//  Trip
//
//  Created by Mauricio Caro on 18-12-23.
//

import Foundation
import Swinject

public struct NetworkingModule {
    private let container: Container
    
    public init(_ container: Container) {
        self.container = container
    }
    public func inject() {
        registerDataLayer()
        registerManager()
    }
}
extension NetworkingModule {
    private func registerDataLayer() {
        container.register(URLSession.self) { _ in
            URLSession.shared
        }
        container.register(NetworkingDataSource.self) { resolve in
            NetworkingDataSourceImp(session: resolve.resolve(URLSession.self))
        }
    }
    private func registerManager() {
        container.register(NetworkingManager.self) { resolve in
            NetworkingManager(dataSource: resolve.resolve(NetworkingDataSource.self))
        }
    }
}
