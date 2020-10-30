//
//  TabBarController.swift
//  homework-3
//
//  Created by Admin on 29.10.2020.
//

//import UIKit
//
//class TabBarController: UITabBarController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        delegate = self
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        //self.viewControllers = [initialTabBar, finalTabBar]
//    }
//    
//    func setupViewControllers() {
//        
//    }
//    
//    static func firstTabViewController() -> FirstViewController {
//        let viewController = FirstViewController()
//        
//        let title = "First"
//        let image = UIImage(named: "defaultImage-initialTabBar.png")!
//        let selectedImage = UIImage(named: "selectedImage-initialTabBar.png")!
//
//        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
//        
//        viewController.tabBarItem = tabBarItem
//
//        return viewController
//    }
//    
//    static func secondTabViewController() -> SecondViewController {
//        let viewController = SecondViewController()
//        
//        let title = "Second"
//        let image = UIImage(named: "defaultImage-initialTabBar.png")!
//        let selectedImage = UIImage(named: "selectedImage-initialTabBar.png")!
//
//        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
//        
//        viewController.tabBarItem = tabBarItem
//
//        return viewController
//    }
//}
//
//extension TabBarController: UITabBarControllerDelegate {
//    
//}
