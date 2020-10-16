//
//  CarDetailViewModel.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import Foundation

class CarDetailViewModel {
    weak var delegate: CarDetailViewModelDelegate?
    
    var manufacturer = ""
    var model        = ""
    var body: Body?
    var yearOfIssue  = ""
    var carNumber    = ""
    
    init(car: Car, delegate: CarDetailViewModelDelegate) {
        manufacturer = car.manufacturer
        model = car.model
        body = car.body
        carNumber = car.carNumber
        
        if car.yearOfIssue != 0 {
            yearOfIssue = String(car.yearOfIssue)
        }
        
        self.delegate = delegate
    }
    
    init(delegate: CarDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func userAddedCar(manufacturer: String, model: String, body: Body, yearOfIssue: String, carNumber: String) {
        if let delegate = delegate {
            let car = Car(manufacturer: manufacturer,
                          model: model,
                          body: body,
                          yearOfIssue: Int(yearOfIssue) ?? 0,
                          carNumber: carNumber)
            
            delegate.carDetailViewModelDelegateAddCar(self, car: car)
        }
    }
    
    func userChangedCar(manufacturer: String, model: String, body: Body, yearOfIssue: String, carNumber: String) {
        if let delegate = delegate {
            let car = Car(manufacturer: manufacturer,
                          model: model,
                          body: body,
                          yearOfIssue: Int(yearOfIssue) ?? 0,
                          carNumber: carNumber)
            
            delegate.carDetailViewModelDelegateChangeCar(self, car: car)
        }
    }
    
    func userDeletedCar() {
        if let delegate = delegate {
            delegate.carDetailViewModelDelegateDeleteCar(self)
        }
    }
}
