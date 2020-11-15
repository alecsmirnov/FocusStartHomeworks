//
//  BodyPickerRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

final class BodyPickerRouter: BodyPickerRouterProtocol {
    private weak var viewController: BodyPickerViewController?
    
    init(viewController: BodyPickerViewController) {
        self.viewController = viewController
    }
    
    func closeBodyPickerView() {
        if viewController?.presentingViewController != nil {
            viewController?.dismiss(animated: true, completion: nil)
        } else {
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
