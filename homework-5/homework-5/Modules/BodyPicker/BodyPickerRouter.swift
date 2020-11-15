//
//  BodyPickerRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

protocol IBodyPickerRouter: AnyObject {
    func closeBodyPickerView()
}

final class BodyPickerRouter {
    private weak var viewController: BodyPickerViewController?
    
    init(viewController: BodyPickerViewController) {
        self.viewController = viewController
    }
}

// MARK: - IBodyPickerRouter

extension BodyPickerRouter: IBodyPickerRouter {
    func closeBodyPickerView() {
        if viewController?.presentingViewController != nil {
            viewController?.dismiss(animated: true, completion: nil)
        } else {
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
