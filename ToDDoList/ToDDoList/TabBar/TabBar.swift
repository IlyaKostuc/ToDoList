//
//  TabBar.swift
//  ToDDoList
//
//  Created by Maxim Fedoseenko on 15.04.2024.
//

import UIKit

class TabBar: UITabBarController {

    private var colorDeafault: UIColor {#colorLiteral(red: 0.3801780305, green: 0.4076312424, blue: 0.4427852878, alpha: 1)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = colorDeafault

        let focusVC = FocusVC()
        focusVC.title = "Focus - Active"
        
        let completeVC = CompleteVC()
        completeVC.title = "Complete"
        
        let aboutVC = AboutVC()
        aboutVC.title = "About"
        
        let navigationVC1 = UINavigationController(rootViewController: focusVC)
        navigationVC1.tabBarItem = UITabBarItem(title: "Focus", image: UIImage(systemName: "map.fill"), tag: 0)
        
        let navigationVC2 = UINavigationController(rootViewController: completeVC)
        navigationVC2.tabBarItem = UITabBarItem(title: "Complete", image: UIImage(systemName: "text.badge.checkmark"), tag: 1)
        
        let navigationVC3 = UINavigationController(rootViewController: aboutVC)
        navigationVC3.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "info.circle.fill"), tag: 2)
        
        viewControllers = [navigationVC1, navigationVC2, navigationVC3]
    }
}
