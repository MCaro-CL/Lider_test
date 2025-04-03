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
        container.register(Coordinator.self) { _ in
            Coordinator(container: self.container)
        }
        container.register(MainTabController.self) { _ in
            MainTabController(self.container)
        }
        
    
    }
}
