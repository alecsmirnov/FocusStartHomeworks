//
//  CarsRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

protocol ICarsRouter: AnyObject {
    func openFilterView(with body: Body?)
    func openCarDetailView(with car: Car?)
}

extension ICarsRouter {
    func openCarDetailView() {
        openCarDetailView(with: nil)
    }
}

final class CarsRouter {
    private weak var viewController: CarsViewController?
    
    init(viewController: CarsViewController) {
        self.viewController = viewController
    }
}

// MARK: - ICarsRouter

extension CarsRouter: ICarsRouter {
    func openFilterView(with body: Body?) {
        let bodyPickerViewController = BodyPickerAssembly.createBodyPickerViewController(
            with: body,
            delegate: viewController
        )
        
        let navigationController = UINavigationController(rootViewController: bodyPickerViewController)
    
        viewController?.present(navigationController, animated: true, completion: nil)
    }
    
    func openCarDetailView(with car: Car?) {
        let carDetailViewController = CarDetailAssembly.createCarDetailViewController(
            with: car,
            delegate: viewController
        )
        
        viewController?.navigationController?.pushViewController(carDetailViewController, animated: true)
    }
}
