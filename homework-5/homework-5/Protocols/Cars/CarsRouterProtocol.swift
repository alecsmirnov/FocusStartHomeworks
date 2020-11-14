//
//  CarsRouterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

import UIKit

protocol CarsRouterProtocol: AnyObject {    
    func openFilterViewController(from viewController: CarsViewControllerProtocol, with body: Body?)
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol, with car: Car?)
}

extension CarsRouterProtocol {
    func openFilterViewController(from viewController: CarsViewControllerProtocol) {
        openFilterViewController(from: viewController, with: nil)
    }
    
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol) {
        openCarDetailViewController(from: viewController, with: nil)
    }
}
