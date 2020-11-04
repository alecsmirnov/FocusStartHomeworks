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
        
        let dataService = createDataService()
        tableViewController.dataService = dataService
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = SplitViewController(
            mainViewController: tableViewController,
            detailViewController: detailViewController
        )
        window?.makeKeyAndVisible()
    }
}

// MARK: - Data Initialization

private extension SceneDelegate {
    func createDataService() -> DataService {
        let dataService = DataService()
        
        let record1 = Record(
            title: "Title 1",
            text: "Text Text Text Text Text Text",
            date: Date.random()
        )
        let record2 = Record(
            title: "Two-line\nTitle",
            text: """
            Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text
            Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text
            Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text
            Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text
            """,
            date: Date.random()
        )
        let record3 = Record(
            title: "Title 3",
            text: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let record4 = Record(
            title: "Title 4",
            text: "Text Text Text Text Text Text Text Text Text",
            date: Date.random()
        )
        let record5 = Record(
            title: "Title 5"
        )
        
        dataService.append(record: record1)
        dataService.append(record: record2)
        dataService.append(record: record3)
        dataService.append(record: record4)
        dataService.append(record: record5)
        
        return dataService
    }
}
