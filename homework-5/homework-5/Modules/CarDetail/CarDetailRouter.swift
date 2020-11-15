//
//  CarDetailRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

final class CarDetailRouter: CarDetailRouterProtocol {
    func openBodyPickerView(from view: CarDetailViewProtocol, with body: Body?) {
        let bodyPickerViewController = Assembly.createBodyPickerViewController(with: body)
        
        bodyPickerViewController.didSelectBody = { body in
            view.setBody(body)
        }
        
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(bodyPickerViewController, animated: true)
        }
    }
    
    func closeCarDetailView(_ view: CarDetailViewProtocol) {
        if let viewController = view as? UIViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
}
