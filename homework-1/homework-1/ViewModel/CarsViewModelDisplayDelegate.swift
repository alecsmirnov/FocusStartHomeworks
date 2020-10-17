//
//  CarsViewModelDisplayDelegate.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

protocol CarsViewModelDisplayDelegate: AnyObject {
    func carsViewModelDisplayDelegate(_ viewModel: CarsViewModel, addCar: Car)
    func carsViewModelDisplayDelegate(_ viewModel: CarsViewModel, reloadRowAt index: Int)
    func carsViewModelDisplayDelegate(_ viewModel: CarsViewModel, deleteRowAt index: Int)
}
