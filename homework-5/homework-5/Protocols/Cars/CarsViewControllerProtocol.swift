//
//  CarsViewControllerProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarsViewControllerProtocol: CarsViewControllerInputProtocol {
    var presenter: CarsPresenterProtocol? { get set }
}

protocol CarsViewControllerInputProtocol: AnyObject {
    var filter: Body? { get set }
}
