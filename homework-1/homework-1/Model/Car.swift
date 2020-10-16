//
//  Car.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import Foundation

struct Car {
    enum Default {
        static let yearOfIssue = 1999
        static let carNumber   = ""
    }
    
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int
    let carNumber: String
    
    init(manufacturer: String, model: String, body: Body, yearOfIssue: Int = Default.yearOfIssue, carNumber: String = Default.carNumber) {
        self.manufacturer = manufacturer
        self.model = model
        self.body = body
        self.yearOfIssue = yearOfIssue
        self.carNumber = carNumber
    }
}
