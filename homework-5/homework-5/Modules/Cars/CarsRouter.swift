//
//  CarsRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

final class CarsRouter: CarsRouterProtocol {
    static func createCarsNavigationController() -> UINavigationController {
        let carsViewController = CarsViewController()
        let carsNavigationController = UINavigationController(rootViewController: carsViewController)
        
        let interactor = CarsInteractor()
        let presenter = CarsPresenter()
        let router = CarsRouter()
        
        carsViewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.viewController = carsViewController
        presenter.interactor = interactor
        presenter.router = router
         
        return carsNavigationController
    }
    
    func openFilterViewController(from viewController: CarsViewControllerProtocol, with body: Body?) {
        let bodyPickerViewController = BodyPickerRouter.createBodyPickerViewController(with: body)
        
        if let bodyPickerViewController = bodyPickerViewController as? BodyPickerViewControllerProtocol {
            bodyPickerViewController.didSelectBody = { body in
                viewController.filter = body
            }
        }
        
        if let viewController = viewController as? UIViewController {
            viewController.present(bodyPickerViewController, animated: true, completion: nil)
        }
    }
    
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol, with car: Car?) {
        let carDetailViewController = CarDetailRouter.createCarDetailViewController(with: car)
        
        if let viewController = viewController as? UIViewController {
            viewController.navigationController?.pushViewController(carDetailViewController, animated: true)
        }
    }
}
