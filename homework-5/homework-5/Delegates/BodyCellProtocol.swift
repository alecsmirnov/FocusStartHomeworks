//
//  BodyCellProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

typealias BodyCellProtocol = BodyCellInputProtocol

protocol BodyCellInputProtocol {
    var body: Body? { get set }
    var checked: Bool { get set }
}
