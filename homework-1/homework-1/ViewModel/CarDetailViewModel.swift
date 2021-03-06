//
//  CarDetailViewModel.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

class CarDetailViewModel {
    weak var delegate: CarDetailViewModelDelegate?
    
    let manufacturer: String?
    let model: String?
    let body: Body?
    let yearOfIssue: String?
    let carNumber: String?
    
    init(delegate: CarDetailViewModelDelegate? = nil) {
        manufacturer = nil
        model = nil
        body = nil
        yearOfIssue = nil
        carNumber = nil
        
        self.delegate = delegate
    }
    
    init(car: Car, delegate: CarDetailViewModelDelegate? = nil) {
        manufacturer = car.manufacturer
        model = car.model
        body = car.body
        carNumber = car.carNumber
        yearOfIssue = car.yearOfIssue?.description
        
        self.delegate = delegate
    }
    
    func userAddedCar(manufacturer: String, model: String, body: Body, yearOfIssue: Int?, carNumber: String?) {
        let car = Car(manufacturer: manufacturer,
                      model: model,
                      body: body,
                      yearOfIssue: yearOfIssue,
                      carNumber: carNumber)
        
        delegate?.carDetailViewModelDelegate(self, addCar: car)
    }
    
    func userChangedCar(manufacturer: String, model: String, body: Body, yearOfIssue: Int?, carNumber: String?) {
        let car = Car(manufacturer: manufacturer,
                      model: model,
                      body: body,
                      yearOfIssue: yearOfIssue,
                      carNumber: carNumber)
        
        delegate?.carDetailViewModelDelegate(self, changeCar: car)
    }
    
    func userDeletedCar() {
        delegate?.carDetailViewModelDelegateDeleteCar(self)
    }
}
