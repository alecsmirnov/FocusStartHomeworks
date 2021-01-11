//
//  SceneDelegate.swift
//  ObserverExample
//
//  Created by Admin on 19.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    let subject = Subject()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let firstViewController = FavoriteViewController()
        let secondViewController = FavoriteViewController()
        let thirdViewController = FavoriteViewController()
        
        firstViewController.subject = subject
        secondViewController.subject = subject
        thirdViewController.subject = subject
        
        let _ = firstViewController.view
        let _ = secondViewController.view
        let _ = thirdViewController.view
        
        firstViewController.tabBarItem = UITabBarItem(
            title: TabBarTitles.first,
            image: TabBarImages.firstCircle, tag: 0
        )
        secondViewController.tabBarItem = UITabBarItem(
            title: TabBarTitles.second,
            image: TabBarImages.secondCircle, tag: 1
        )
        thirdViewController.tabBarItem = UITabBarItem(
            title: TabBarTitles.third,
            image: TabBarImages.thirdCircle, tag: 2
        )
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
