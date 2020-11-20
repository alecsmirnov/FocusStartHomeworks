//
//  SceneDelegate.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = CarsAssembly.createCarsNavigationController()
        window?.makeKeyAndVisible()
    }
}
