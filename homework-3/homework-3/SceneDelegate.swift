//
//  SceneDelegate.swift
//  homework-3
//
//  Created by Admin on 29.10.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private enum Titles {
        static let first = "First"
        static let second = "Second"
        static let third = "Third"
    }
    
    private enum Images {
        static let firstCircle = UIImage(systemName: "1.circle.fill")
        static let secondCircle = UIImage(systemName: "2.circle.fill")
        static let thirdCircle = UIImage(systemName: "3.circle.fill")
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let firstViewController = FirstViewController()
        let secondViewController = SecondViewController()
        let thirdViewController = ThirdViewController()
        
        firstViewController.tabBarItem = UITabBarItem(title: Titles.first, image: Images.firstCircle, tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: Titles.second, image: Images.secondCircle, tag: 1)
        thirdViewController.tabBarItem = UITabBarItem(title: Titles.third, image: Images.thirdCircle, tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
