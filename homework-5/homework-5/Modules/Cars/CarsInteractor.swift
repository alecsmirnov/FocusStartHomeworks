//
//  CarsInteractor.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

protocol CarsInteractorProtocol: AnyObject {
    var presenter: CarsPresenterProtocol? { get set }

    var isEmpty: Bool { get }
    var count: Int { get }
    
    func append(car: Car)
    func remove(at index: Int)
    func get(at index: Int) -> Car
}

final class CarsInteractor: CarsInteractorProtocol {
    var presenter: CarsPresenterProtocol?
    
    var isEmpty: Bool {
        data.isEmpty
    }
    
    var count: Int {
        data.count
    }
    
    private let data = CarService.mockData()
    
    func append(car: Car) {
        data.append(car: car)
    }
    
    func remove(at index: Int) {
        data.remove(at: index)
    }
    
    func get(at index: Int) -> Car {
        return data.get(at: index)
    }
}
