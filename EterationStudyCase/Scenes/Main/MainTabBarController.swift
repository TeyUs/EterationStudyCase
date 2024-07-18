//
//  MainTabBarController.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 15.07.2024.
//

import UIKit

class MainTabBarController: UITabBarController, StoryboardLoadable {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        
        let productViewController = UIStoryboard.loadViewController() as ProductsViewController
        productViewController.viewModel = ProductsViewModel(view: productViewController)
        let productNavBar = UINavigationController(rootViewController: productViewController)
        productNavBar.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        
        let cartViewController = UIStoryboard.loadViewController() as CartViewController
        cartViewController.viewModel = CartViewModel(view: cartViewController)
        let cartNavBar = UINavigationController(rootViewController: cartViewController)
        cartNavBar.tabBarItem = UITabBarItem(title: "", image: .basketIcon, selectedImage: .basketIcon)
        
        viewControllers = [productNavBar, cartNavBar]
    }
    
}
