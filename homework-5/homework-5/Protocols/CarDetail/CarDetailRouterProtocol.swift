//
//  CarDetailRouterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

import UIKit

protocol CarDetailRouterProtocol: AnyObject {
    static func createCarDetailViewController(with car: Car?) -> UIViewController
    
    func openBodyPickerViewController(from viewController: CarDetailViewControllerProtocol, with body: Body?)
    func closeCarDetailViewController(_ viewController: CarDetailViewControllerProtocol)
}
