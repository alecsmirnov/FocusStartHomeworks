//
//  CarsInteractor.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

final class CarsInteractor: CarsInteractorProtocol {
    var presenter: CarsPresenterProtocol?
    
    private let data = CarService.mockData()
}

extension CarsInteractor {
    var isEmpty: Bool {
        data.isEmpty
    }
    
    var count: Int {
        data.count
    }
}

extension CarsInteractor {
    func append(car: Car) {
        data.append(car: car)
    }
    
    func replace(at index: Int, with car: Car) {
        data.replace(at: index, with: car)
    }
    
    func remove(at index: Int) {
        data.remove(at: index)
    }
    
    func get(at index: Int) -> Car {
        return data.get(at: index)
    }
    
    func filter(by body: Body) {
        data.filter(by: body)
    }
    
    func filterReset() {
        data.filterReset()
    }
}
