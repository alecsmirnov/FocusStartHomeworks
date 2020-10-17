//
//  Car.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

struct Car {    
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int?
    let carNumber: String?
}

// MARK: - Equatable

extension Car: Equatable {}
