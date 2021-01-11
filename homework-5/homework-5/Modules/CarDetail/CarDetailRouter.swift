//
//  CarDetailRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

protocol ICarDetailRouter: AnyObject {
    func openBodyPickerView(with body: Body?)
    func closeCarDetailView()
}

final class CarDetailRouter {
    private weak var viewController: CarDetailViewController?
    
    init(viewController: CarDetailViewController) {
        self.viewController = viewController
    }
}

// MARK: - ICarDetailRouter

extension CarDetailRouter: ICarDetailRouter {
    func openBodyPickerView(with body: Body?) {
        if let viewController = viewController {
            let bodyPickerViewController = BodyPickerAssembly.createBodyPickerViewController(
                with: body,
                delegate: viewController
            )
            
            viewController.navigationController?.pushViewController(bodyPickerViewController, animated: true)
        }
    }
    
    func closeCarDetailView() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
