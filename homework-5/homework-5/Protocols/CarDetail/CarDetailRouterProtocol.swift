//
//  CarDetailRouterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

import UIKit

protocol CarDetailRouterProtocol: AnyObject {    
    func openBodyPickerViewController(from viewController: CarDetailViewControllerProtocol, with body: Body?)
    func closeCarDetailViewController(_ viewController: CarDetailViewControllerProtocol)
}
