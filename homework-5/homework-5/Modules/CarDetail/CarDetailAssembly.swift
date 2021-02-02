//
//  CarDetailAssembly.swift
//  homework-5
//
//  Created by Admin on 15.11.2020.
//

import UIKit

enum CarDetailAssembly {
    static func createCarDetailViewController(
        with car: Car?,
        delegate: CarDetailViewControllerDelegate? = nil
    ) -> CarDetailViewController {
        let viewController = CarDetailViewController()
        
        let interactor = CarDetailInteractor()
        let presenter = CarDetailPresenter()
        let router = CarDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.setCarToEdit(car)
        presenter.delegate = delegate
         
        return viewController
    }
}
