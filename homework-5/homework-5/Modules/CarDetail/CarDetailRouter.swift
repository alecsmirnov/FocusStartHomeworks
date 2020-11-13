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
        let bodyPickerViewController = BodyPickerRouter.createBodyPickerViewController(with: body)
        
        if let bodyPickerViewController = bodyPickerViewController as? BodyPickerViewControllerProtocol {
            bodyPickerViewController.didSelectBody = { body in
                viewController.bodyToReceive = body
            }
        }
        
        if let viewController = viewController as? UIViewController {
            viewController.navigationController?.pushViewController(bodyPickerViewController, animated: true)
        }
    }
}
