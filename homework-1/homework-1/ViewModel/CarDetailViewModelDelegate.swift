//
//  CarDetailViewModelDelegate.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

protocol CarDetailViewModelDelegate: AnyObject {
    func carDetailViewModelDelegateAddCar(_ viewModel: CarDetailViewModel, car: Car)
    func carDetailViewModelDelegateChangeCar(_ viewModel: CarDetailViewModel, car: Car)
    func carDetailViewModelDelegateDeleteCar(_ viewModel: CarDetailViewModel)
}
