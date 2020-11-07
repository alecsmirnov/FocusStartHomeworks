//
//  SceneDelegate.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tableViewController = TableViewController()
        let detailViewController = DetailViewController()
        
        tableViewController.data = DataService.mockObject()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = SplitViewController(
            mainViewController: tableViewController,
            detailViewController: detailViewController
        )
        window?.makeKeyAndVisible()
    }
}
