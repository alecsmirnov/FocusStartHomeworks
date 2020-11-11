//
//  SceneDelegate.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private weak var carDetailViewController: CarDetailViewController?
    
    private let carsViewController = CarsViewController()
    private let navigationController = UINavigationController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        carsViewController.delegate = self
        carsViewController.data = CarService.mockData()
        
        navigationController.viewControllers = [carsViewController]
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

// MARK: - BodySelectionDelegate

extension SceneDelegate: BodySelectionDelegate {
    func bodySelectionDelegate(_ viewController: UIViewController, didSelect body: Body?) {
        switch viewController {
        case is CarDetailViewController:
            let bodyPickerViewController = BodyPickerViewController()
            bodyPickerViewController.delegate = self
            bodyPickerViewController.bodyToSelect = body
            
            navigationController.pushViewController(bodyPickerViewController, animated: true)
        case is BodyPickerViewController:
            if let carDetailViewController = carDetailViewController {
                carDetailViewController.bodyToReceive = body
            } else {
                carsViewController.setFilter(body: body)
            }
            
            navigationController.popViewController(animated: true)
        default: break
        }
    }
}

// MARK: - CarsViewControllerDelegate

extension SceneDelegate: CarsViewControllerDelegate {
    func carsViewControllerDelegateDidTapFilter(_ viewController: CarsViewController) {
        let bodyPickerViewController = BodyPickerViewController()
        bodyPickerViewController.delegate = self
        
        navigationController.pushViewController(bodyPickerViewController, animated: true)
    }
    
    func carsViewControllerDelegateDidTapAdd(_ viewController: CarsViewController) {
        let carDetailViewController = CarDetailViewController()
        carDetailViewController.delegate = self
        
        navigationController.pushViewController(carDetailViewController, animated: true)
    }
    
    func carsViewControllerDelegate(_ viewController: CarsViewController, didSelect car: Car) {
        let carDetailViewController = CarDetailViewController()
        
        self.carDetailViewController = carDetailViewController
        carDetailViewController.delegate = self
        carDetailViewController.carToEdit = car
        
        navigationController.pushViewController(carDetailViewController, animated: true)
    }
}
