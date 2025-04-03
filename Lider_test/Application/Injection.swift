import Foundation
import UIKit
import Swinject

final class Injection {
    private static let _shared = Injection()
    
    public static var shared: Injection {
        _shared
    }
    
    private let container: Container
    private let mainModule: MainModule
    
    private init() {
        container = Container()
        mainModule = MainModule(container)
        inject()
    }
    
    private func inject() {
        injectManager()
        injectModule()
    }
    
    func getRootViewController() -> UIViewController {
        return container.resolve(MainTabController.self)
    }
    
    func injectManager() {
        NetworkingModule(container).inject()
    }
    
    func injectModule() {
        MainModule(container).inject()
        HomeModule(container).inject()
    }
}
extension Resolver {
    func resolve<Service>(_ serviceType: Service.Type, name: String? = nil) -> Service {
        guard let service = resolve(serviceType, name: name) else {
            fatalError("El servicio \(String(describing: Service.self)) no ha sido registrado")
        }
        return service
    }
}
