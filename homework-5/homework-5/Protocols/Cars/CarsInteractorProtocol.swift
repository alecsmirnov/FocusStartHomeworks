//
//  CarsInteractorProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarsInteractorProtocol: AnyObject {
    var isEmpty: Bool { get }
    var count: Int { get }
    
    func append(car: Car)
    func replace(at index: Int, with car: Car)
    func remove(at index: Int)
    func get(at index: Int) -> Car
    
    func filter(by body: Body)
    func filterReset()
}
