//
//  BaseTabBarController.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/18/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTabBarViewControllers()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .yellow
        
    }
    
    fileprivate func generateTabNavController(with controller: UIViewController, title: String, imageName: String) -> UIViewController {
        
        controller.view.backgroundColor = .white
        controller.navigationItem.title = title
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        return navController
    }
    
    fileprivate func setupTabBarViewControllers() {
        viewControllers = [
            generateTabNavController(with: TodayController(), title: Const.NavTitle.today, imageName: Const.Image.today),
            generateTabNavController(with: AppsPageController(), title: Const.NavTitle.apps, imageName: Const.Image.apps),
            generateTabNavController(with: AppsSearchController(), title: Const.NavTitle.search, imageName: Const.Image.search)
        ]
        
    }
}
