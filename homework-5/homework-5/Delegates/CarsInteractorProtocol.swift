//
//  CarsInteractorProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarsInteractorProtocol: CarsInteractorInputOutputProtocol {
    var presenter: CarsPresenterProtocol? { get set }
}

protocol CarsInteractorInputOutputProtocol: AnyObject {
    var isEmpty: Bool { get }
    var count: Int { get }
    
    func append(car: Car)
    func remove(at index: Int)
    func get(at index: Int) -> Car
}
