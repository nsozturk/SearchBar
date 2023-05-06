//
//  MainTabBarViewController.swift
//  SearchBar
//
//  Created by enes ozturk on 6.05.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearhViewController())

        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        vc1.title = "Home"
        vc2.title = "Search"

        tabBar.tintColor = .label
        setViewControllers([vc2], animated: true)
    }
}
