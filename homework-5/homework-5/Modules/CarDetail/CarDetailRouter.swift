//
//  CarDetailRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

protocol CarDetailRouterProtocol: AnyObject {
    static func createCarDetailViewController(with car: Car?) -> UIViewController
    
    func openBodyPickerViewController(from viewController: CarDetailViewControllerProtocol, with body: Body?)
}

final class CarDetailRouter: CarDetailRouterProtocol {
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
    
    func openBodyPickerViewController(from viewController: CarDetailViewControllerProtocol, with body: Body?) {
        guard let viewController = viewController as? UIViewController else {
            fatalError("invalid view controller protocol")
        }

        let bodyPickerViewController = BodyPickerRouter.createBodyPickerViewController(with: body)

        viewController.present(bodyPickerViewController, animated: true, completion: nil)
    }
}
