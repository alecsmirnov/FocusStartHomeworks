//
//  SceneDelegate.swift
//  homework-3
//
//  Created by Admin on 29.10.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let firstViewController = FirstViewController()
        let secondViewController = SecondViewController()
        let thirdViewController = ThirdViewController()
        
        firstViewController.tabBarItem = UITabBarItem(title: TabBarTitles.first, image: TabBarImages.firstCircle, tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: TabBarTitles.second, image: TabBarImages.secondCircle, tag: 1)
        thirdViewController.tabBarItem = UITabBarItem(title: TabBarTitles.third, image: TabBarImages.thirdCircle, tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
