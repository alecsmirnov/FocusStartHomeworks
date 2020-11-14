//
//  Assembly.swift
//  homework-5
//
//  Created by Admin on 14.11.2020.
//

import UIKit

enum Assembly {
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
    
    static func createCarDetailViewController(with car: Car?) -> UIViewController {
        let carDetailViewController = CarDetailViewController()
        
        let interactor = CarDetailInteractor()
        let presenter = CarDetailPresenter()
        let router = CarDetailRouter()
        
        carDetailViewController.presenter = presenter
        carDetailViewController.carToEdit = car
        
        interactor.presenter = presenter
        
        presenter.viewController = carDetailViewController
        presenter.interactor = interactor
        presenter.router = router
         
        return carDetailViewController
    }
    
    static func createBodyPickerViewController(with body: Body?) -> UIViewController {
        let bodyPickerViewController = BodyPickerViewController()
        
        let interactor = BodyPickerInteractor()
        let presenter = BodyPickerPresenter()
        let router = BodyPickerRouter()
        
        bodyPickerViewController.presenter = presenter
        bodyPickerViewController.selectedBody = body
        
        interactor.presenter = presenter
        
        presenter.viewController = bodyPickerViewController
        presenter.interactor = interactor
        presenter.router = router
         
        return bodyPickerViewController
    }
}
