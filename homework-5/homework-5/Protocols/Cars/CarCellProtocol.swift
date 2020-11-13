//
//  CarCellProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

typealias CarCellProtocol = CarCellInputProtocol

protocol CarCellInputProtocol: AnyObject {
    func configure(with car: Car)
}
