//
//  CarsRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

final class CarsRouter: CarsRouterProtocol {
    func openFilterView(from view: CarsViewProtocol, with body: Body?) {
        let bodyPickerViewController = Assembly.createBodyPickerViewController(with: body)
        
        if let bodyPickerView = bodyPickerViewController as? BodyPickerViewProtocol {
            bodyPickerView.didSelectBody = { body in
                view.setFilter(with: body)
            }
        }
        
        if let viewController = view as? UIViewController {
            let navigationController = UINavigationController(rootViewController: bodyPickerViewController)
            
            viewController.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func openCarDetailView(from view: CarsViewProtocol, with car: Car?) {
        let carDetailViewController = Assembly.createCarDetailViewController(with: car)
        
        if let carDetailViewController = carDetailViewController as? CarDetailViewController,
           let viewController = view as? CarsViewController {
            carDetailViewController.delegate = viewController
        }
        
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(carDetailViewController, animated: true)
        }
    }
}
