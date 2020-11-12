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
//        guard let viewController = viewController as? UIViewController else {
//            fatalError("invalid view controller protocol")
//        }
//
//        let bodyPickerViewController = BodyPickerRouter.createBodyPickerViewController(with: body)
//
//        viewController.navigationController?.pushViewController(bodyPickerViewController, animated: true)
    }
    
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol, with car: Car?) {
        guard let viewController = viewController as? UIViewController else {
            fatalError("invalid view controller protocol")
        }
        
        let carDetailViewController = CarDetailRouter.createCarDetailViewController(with: car)
        
        viewController.navigationController?.pushViewController(carDetailViewController, animated: true)
    }
}
