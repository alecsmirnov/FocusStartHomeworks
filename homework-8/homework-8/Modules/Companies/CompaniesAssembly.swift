//
//  CompaniesAssembly.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

import UIKit

enum CompaniesAssembly {
    static func createCompaniesNavigationController() -> UINavigationController {
        let viewController = CompaniesViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let interactor = CompaniesInteractor()
        let presenter = CompaniesPresenter()
        let router = CompaniesRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
         
        return navigationController
    }
}
