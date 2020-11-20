//
//  CarsAssembly.swift
//  homework-5
//
//  Created by Admin on 15.11.2020.
//

import UIKit

enum CarsAssembly {
    static func createCarsNavigationController() -> UINavigationController {
        let viewController = CarsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let interactor = CarsInteractor()
        let presenter = CarsPresenter()
        let router = CarsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
         
        return navigationController
    }
}
