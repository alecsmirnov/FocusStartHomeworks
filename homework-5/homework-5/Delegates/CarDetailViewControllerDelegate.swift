//
//  CarDetailViewControllerDelegate.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarDetailViewControllerDelegate: AnyObject {
    func carsViewControllerDelegate(_ viewController: CarDetailViewController, addNew car: Car)
    func carsViewControllerDelegate(_ viewController: CarDetailViewController, edit car: Car)
    func carsViewControllerDelegateDeleteCar(_ viewController: CarDetailViewController)
}
