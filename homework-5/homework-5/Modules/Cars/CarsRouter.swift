//
//  CarsRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

protocol CarsRouterProtocol: AnyObject {
    static func createCarsNavigationController() -> UINavigationController
    
    func openFilterViewController(from viewController: CarsViewControllerProtocol, with body: Body?)
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol, with car: Car?)
}

extension CarsRouterProtocol {
    func openFilterViewController(from viewController: CarsViewControllerProtocol) {
        openFilterViewController(from: viewController, with: nil)
    }
    
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol) {
        openCarDetailViewController(from: viewController, with: nil)
    }
}

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
        guard let viewController = viewController as? UIViewController else {
            fatalError("invalid view controller protocol")
        }

        let bodyPickerViewController = BodyPickerRouter.createBodyPickerViewController(with: body)

        viewController.navigationController?.pushViewController(bodyPickerViewController, animated: true)
    }
    
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol, with car: Car?) {
        guard let viewController = viewController as? UIViewController else {
            fatalError("invalid view controller protocol")
        }
        
        let carDetailViewController = CarDetailRouter.createCarDetailViewController(with: car)
        
        viewController.navigationController?.pushViewController(carDetailViewController, animated: true)
    }
}
