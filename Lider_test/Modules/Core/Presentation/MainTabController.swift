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
fileprivate extension MainTabController{
    func setupUI(){
        let home = create(
            controller: container.resolve(HomeViewController.self),
            title: NSLocalizedString("GENERAL_HOME", comment: ""),
            icon: UIImage(systemName: "house.circle.fill"),
            navBar: true
        )
        self.viewControllers = [home]
        self.tabBar.barStyle = .black
        self.tabBar.tintColor = .white
        tabBar.isTranslucent = false
    }
    
    func create(controller: UIViewController, title:String, icon: UIImage?, navBar:Bool = false)-> UIViewController{
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
}
