//
//  GFTabBarController.swift
//  GitHub
//
//  Created by Adam Paluszewski on 15/09/2022.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesListNC()]
    }
    
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavoritesListNC() -> UINavigationController {
        let searchVC = FavoritesListVC()
        searchVC.title = "Favorites"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: searchVC)
    }
   
}
