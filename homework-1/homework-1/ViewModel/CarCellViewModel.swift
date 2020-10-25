//
//  CarCellViewModel.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

struct CarCellViewModel {
    let manufacturer: String
    let model: String
    let body: String
    let yearOfIssue: String?
    
    init(car: Car) {
        manufacturer = car.manufacturer
        model = car.model
        body = car.body.description
        yearOfIssue = car.yearOfIssue?.description
    }
}
