//
//  CarDetailViewModelDelegate.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

protocol CarDetailViewModelDelegate: AnyObject {
    func carDetailViewModelDelegate(_ viewModel: CarDetailViewModel, addCar car: Car)
    func carDetailViewModelDelegate(_ viewModel: CarDetailViewModel, changeCar car: Car)
    func carDetailViewModelDelegateDeleteCar(_ viewModel: CarDetailViewModel)
}
