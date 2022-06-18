//
//  TabBarViewController.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 18/10/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedVC = FeedViewController()
        let tagsVC = TagsViewController()
        let chatVC = ChatViewController()
        
        let nav1 = UINavigationController(rootViewController: feedVC)
        let nav2 = UINavigationController(rootViewController: tagsVC)
        let nav3 = UINavigationController(rootViewController: chatVC)
        nav2.navigationBar.isHidden = true
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Tags", image: UIImage(systemName: "tag"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "message"), tag: 3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
    
    
}
