//
//  Coordinator.swift
//  SmartContacts
//
//  Created by Mauricio Caro on 08-08-22.
//

import UIKit
import Swinject


final class Coordinator{
    private let container: Container
    
    init(container:Container){
        self.container = container
    }
    private func resolveNoArguments<V:UIViewController>(
        to: V.Type)-> V{
            return container.resolve(V.self)
    }
    private func resolveWithArguments<V:UIViewController,T>(
        to: V.Type,
        args:T)-> V{
            return container.resolve(V.self, argument: args)!
    }
    
    func pushViewController<V:UIViewController>(from: UIViewController, to: V.Type){
        let newVC: V = resolveNoArguments(to: to)
        from.navigationController?.pushViewController(newVC, animated: true)
    }
    func pushViewController<V:UIViewController, T>(from: UIViewController, to: V.Type, args: T){
        let newVC: V = resolveWithArguments(to: to, args: args)
        from.navigationController?.pushViewController(newVC, animated: true)
    }
    func presentViewController<V:UIViewController>(from: UIViewController, to: V.Type){
        let newVC: V = resolveNoArguments(to: to)
        from.present(newVC, animated: true)
    }
    func presentViewController<V:UIViewController, T>(from: UIViewController, to: V.Type, args: T){
        let newVC: V = resolveWithArguments(to: to, args: args)
        from.present(newVC, animated: true)
    }
    func presentViewController<T: UIViewController>(
        from source: UIViewController,
        to type: T.Type,
        delegate: ((T) -> Void)? = nil
    ) {
        // Se resuelve la instancia a través del contenedor de dependencias
        guard let viewController = container.resolve(T.self) else {
            assertionFailure("No se pudo resolver \(T.self)")
            return
        }
        
        // Ejecutar el bloque de configuración, si se proporciona
        delegate?(viewController)
        
        // Realizar la presentación
        source.present(viewController, animated: true, completion: nil)
    }
}
