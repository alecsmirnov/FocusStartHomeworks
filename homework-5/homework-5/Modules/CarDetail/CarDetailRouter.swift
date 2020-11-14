//
//  CarDetailRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

final class CarDetailRouter: CarDetailRouterProtocol {
    func openBodyPickerViewController(from viewController: CarDetailViewControllerProtocol, with body: Body?) {
        let bodyPickerViewController = Assembly.createBodyPickerViewController(with: body)
        
        if let bodyPickerViewController = bodyPickerViewController as? BodyPickerViewControllerProtocol {
            bodyPickerViewController.didSelectBody = { body in
                viewController.bodyToReceive = body
            }
        }
        
        if let viewController = viewController as? UIViewController {
            viewController.navigationController?.pushViewController(bodyPickerViewController, animated: true)
        }
    }
    
    func closeCarDetailViewController(_ viewController: CarDetailViewControllerProtocol) {
        if let viewController = viewController as? UIViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
}
