//
//  TabBarController.swift
//  demoDelivery
//
//  Created by Pavel Mac on 22.07.2025.
//

import Foundation
import UIKit


final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTabs()
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = UIColor.systemPink
    }
    
    private func setupTabs() {
        let menuVC = MenuViewController()
        let contactsVC = ContactsViewController()
        let profileVC = ProfileViewController()
        let cartVC = CartViewController()
        
        menuVC.tabBarItem = UITabBarItem(title: "Меню", image: UIImage(named: "tab-menu"), tag: 0)
        contactsVC.tabBarItem = UITabBarItem(title: "Контакты", image: UIImage(named: "tab-contacts"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "tab-profile"), tag: 2)
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "tab-basket"), tag: 3)
        viewControllers = [menuVC, contactsVC, profileVC, cartVC]
    }
}
