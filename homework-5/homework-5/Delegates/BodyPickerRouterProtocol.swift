//
//  BodyPickerRouterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

import UIKit

protocol BodyPickerRouterProtocol: AnyObject {
    static func createBodyPickerViewController(with body: Body?) -> UIViewController
    
    func closeBodyPickerViewController(_ viewController: BodyPickerViewControllerProtocol)
}
