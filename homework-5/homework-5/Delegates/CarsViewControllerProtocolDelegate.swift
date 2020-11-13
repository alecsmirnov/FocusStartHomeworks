//
//  CarsViewControllerDelegate.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

protocol CarsViewControllerProtocolDelegate: AnyObject {
    func carsViewControllerProtocolDelegateApplyFilter(_ viewController: CarsViewController, with body: Body?)
    func carsViewControllerProtocolDelegateDidTapAdd(_ viewController: CarsViewController)
    func carsViewControllerProtocolDelegate(_ viewController: CarsViewController, didSelect car: Car)
}
