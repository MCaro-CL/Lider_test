//
//  MainTabController.swift
//  SmartContacts
//
//  Created by Mauricio Caro on 08-07-22.
//

import Foundation
import UIKit
import Swinject

final class MainTabController: UITabBarController{
    private let container:Container
    
    init(_ container: Container ){
        self.container = container
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: Private methods
extension MainTabController{
    private func setupUI(){
        customizerTabBar()
        let home = create(
            controller: container.resolve(HomeViewController.self),
            title: NSLocalizedString("GENERAL_HOME", comment: ""),
            icon: UIImage(systemName: "house.circle.fill"),
            navBar: true
        )
        let cart = create(
            controller: container.resolve(CartViewController.self),
            title: NSLocalizedString("GENERAL_CART", comment: ""),
            icon: UIImage(systemName: "cart"),
            navBar: true
        )
        self.viewControllers = [home, cart]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleUpdateBadgeNotification(_:)),
                                               name: NSNotification.Name("updatedRepository"),
                                               object: nil)
    }
    
    private func create(controller: UIViewController, title:String, icon: UIImage?, navBar:Bool = false)-> UIViewController{
        if navBar{
            let navBar = UINavigationController(rootViewController: controller)
            navBar.tabBarItem = UITabBarItem(title: title, image: icon, tag: 0)
            navBar.navigationBar.prefersLargeTitles = true
            navBar.navigationBar.tintColor = .label
            
            return navBar
        }else{
            let tabItem = UITabBarItem(title: title, image: icon, tag: 1)
            controller.tabBarItem = tabItem
            return controller
        }
        
    }
    
    @objc
    private func handleUpdateBadgeNotification(_ notification: Notification) {
            // Extraer el valor enviado en el objeto de la notificación.
            if let count = notification.object as? Int {
                // Asumimos que el Cart está en la posición 1 del array de viewControllers.
                if let cartController = self.viewControllers?[1] {
                    cartController.tabBarItem.badgeValue = count > 0 ? "\(count)" : nil
                }
            }
        }
    
    private func customizerTabBar(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .trueBlue
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(1)
    }
}
