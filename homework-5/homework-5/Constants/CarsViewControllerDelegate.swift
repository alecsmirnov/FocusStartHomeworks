//
//  CarsViewControllerDelegate.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

protocol CarsViewControllerDelegate: AnyObject {
    func carsViewControllerDelegateDidTapFilter(_ viewController: CarsViewController)
    func carsViewControllerDelegateDidTapAdd(_ viewController: CarsViewController)
    func carsViewControllerDelegate(_ viewController: CarsViewController, didSelect car: Car)
}
