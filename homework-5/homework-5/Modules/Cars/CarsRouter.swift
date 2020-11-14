//
//  CarsRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

final class CarsRouter: CarsRouterProtocol {
    func openFilterViewController(from viewController: CarsViewControllerProtocol, with body: Body?) {
        let bodyPickerViewController = Assembly.createBodyPickerViewController(with: body)
        
        if let bodyPickerViewController = bodyPickerViewController as? BodyPickerViewControllerProtocol {
            bodyPickerViewController.didSelectBody = { body in
                viewController.filter = body
            }
        }
        
        if let viewController = viewController as? UIViewController {
            let navigationController = UINavigationController(rootViewController: bodyPickerViewController)
            
            viewController.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol, with car: Car?) {
        let carDetailViewController = Assembly.createCarDetailViewController(with: car)
        
        if let carDetailViewController = carDetailViewController as? CarDetailViewController,
           let viewController = viewController as? CarsViewController {
            carDetailViewController.delegate = viewController
        }
        
        if let viewController = viewController as? UIViewController {
            viewController.navigationController?.pushViewController(carDetailViewController, animated: true)
        }
    }
}
