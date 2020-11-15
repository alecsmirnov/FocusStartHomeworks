//
//  Assembly.swift
//  homework-5
//
//  Created by Admin on 14.11.2020.
//

import UIKit

enum Assembly {
    static func createCarsNavigationController() -> UINavigationController {
        let view = CarsViewController()
        let navigationController = UINavigationController(rootViewController: view)
        
        let interactor = CarsInteractor()
        let presenter = CarsPresenter()
        let router = CarsRouter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
         
        return navigationController
    }
    
    static func createCarDetailViewController(with car: Car?) -> CarDetailViewController {
        let view = CarDetailViewController()
        
        let presenter = CarDetailPresenter()
        let router = CarDetailRouter()
        
        view.presenter = presenter
        view.carToEdit = car
        
        presenter.view = view
        presenter.router = router
         
        return view
    }
    
    static func createBodyPickerViewController(with body: Body?) -> BodyPickerViewController {
        let view = BodyPickerViewController()
        
        let presenter = BodyPickerPresenter()
        let router = BodyPickerRouter()
        
        view.presenter = presenter
        view.selectedBody = body
        
        presenter.view = view
        presenter.router = router
         
        return view
    }
}
