//
//  CarsPresenterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarsPresenterProtocol: AnyObject {    
    var isEmpty: Bool { get }
    var count: Int { get }
    
    func append(car: Car)
    func replace(at index: Int, with car: Car)
    func remove(at index: Int)
    func get(at index: Int) -> Car?
    
    func setFilter(by body: Body?)
    
    func didPressFilterButton(with body: Body?)
    func didPressAddButton()
    func didSelectRow(with car: Car)
}
