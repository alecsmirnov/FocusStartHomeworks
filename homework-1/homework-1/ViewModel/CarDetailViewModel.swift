//
//  CarDetailViewModel.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import Foundation

class CarDetailViewModel {
    let manufacturer: String
    let model: String
    let body: String
    let yearOfIssue: String
    let carNumber: String
    
    weak var delegate: CarDetailViewModelDelegate?
    
    init(car: Car, delegate: CarDetailViewModelDelegate?) {
        manufacturer = car.manufacturer
        model = car.model
        body = car.body.rawValue
        yearOfIssue = String(car.yearOfIssue)
        carNumber = car.carNumber
        
        self.delegate = delegate
    }
    
    func userAddedCar(manufacturer: String, model: String, body: Body, yearOfIssue: String, carNumber: String) {
        if let delegate = delegate {
            let car = Car(manufacturer: manufacturer,
                          model: model,
                          body: Body.coupe,
                          yearOfIssue: Int(yearOfIssue) ?? Car.Default.yearOfIssue,
                          carNumber: carNumber)
            
            delegate.carDetailViewModelDelegateAddCar(self, car: car)
        }
    }
    
    func userChangedCar(manufacturer: String, model: String, body: Body, yearOfIssue: String, carNumber: String) {
        if let delegate = delegate {
            let car = Car(manufacturer: manufacturer,
                          model: model,
                          body: Body.coupe,
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
