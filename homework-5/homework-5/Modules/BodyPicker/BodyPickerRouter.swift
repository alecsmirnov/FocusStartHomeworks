//
//  BodyPickerRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

final class BodyPickerRouter: BodyPickerRouterProtocol {
    func closeBodyPickerView(_ view: BodyPickerViewProtocol) {
        guard let viewController = view as? UIViewController else { return }
        
        if viewController.presentingViewController != nil {
            viewController.dismiss(animated: true, completion: nil)
        } else {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
}
