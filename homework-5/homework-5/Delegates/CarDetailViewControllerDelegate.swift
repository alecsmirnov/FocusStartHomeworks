//
//  CarDetailViewControllerDelegate.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarDetailViewControllerDelegate: AnyObject {
    func carsViewControllerDelegate(_ anyObject: AnyObject, addNew car: Car)
    func carsViewControllerDelegate(_ anyObject: AnyObject, edit car: Car)
    func carsViewControllerDelegateDeleteCar(_ anyObject: AnyObject)
}
