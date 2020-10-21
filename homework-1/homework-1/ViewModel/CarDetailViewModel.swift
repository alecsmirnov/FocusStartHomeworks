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
    
    init(car: Car, delegate: CarDetailViewModelDelegate) {
        manufacturer = car.manufacturer
        model = car.model
        body = car.body
        carNumber = car.carNumber
        
        if let carYearOfIssue = car.yearOfIssue {
            yearOfIssue = String(carYearOfIssue)
        }
        else {
            yearOfIssue = "-"
        }
        
        self.delegate = delegate
    }
    
    init(delegate: CarDetailViewModelDelegate) {
        manufacturer = nil
        model = nil
        body = nil
        yearOfIssue = nil
        carNumber = nil
        
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
