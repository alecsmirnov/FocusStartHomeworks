//
//  CarDetailViewModel.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import Foundation

class CarDetailViewModel {
    var manufacturer: String?
    var model: String?
    var body: Body?
    var yearOfIssue: String?
    var carNumber: String?
    
    weak var delegate: CarDetailViewModelDelegate?
    
    init(car: Car, delegate: CarDetailViewModelDelegate) {
        manufacturer = car.manufacturer
        model = car.model
        body = car.body
        yearOfIssue = String(car.yearOfIssue)
        carNumber = car.carNumber
        
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
                          yearOfIssue: Int(yearOfIssue) ?? Car.Default.yearOfIssue,
                          carNumber: carNumber)
            
            delegate.carDetailViewModelDelegateAddCar(self, car: car)
        }
    }
    
    func userChangedCar(manufacturer: String, model: String, body: Body, yearOfIssue: String, carNumber: String) {
        if let delegate = delegate {
            let car = Car(manufacturer: manufacturer,
                          model: model,
                          body: body,
                          yearOfIssue: Int(yearOfIssue) ?? Car.Default.yearOfIssue,
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
