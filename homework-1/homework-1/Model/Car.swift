//
//  Car.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import Foundation

struct Car {    
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int
    let carNumber: String
}

extension Car: Equatable {}
