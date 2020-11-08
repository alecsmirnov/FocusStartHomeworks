//
//  SceneDelegate.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private var splitViewCoordinator: SplitViewCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let splitViewController = UISplitViewController(style: .doubleColumn)
        
        splitViewCoordinator = SplitViewCoordinator(splitViewController: splitViewController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
    }
}
