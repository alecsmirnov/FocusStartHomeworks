//
//  CarsInteractor.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

protocol ICarsInteractor: AnyObject {
    var count: Int { get }
    
    func setFilter(by body: Body?)
    func getFilter() -> Body?
    
    func append(car: Car)
    func replace(at index: Int, with car: Car)
    func remove(at index: Int)
    
    func get(at index: Int) -> Car
}

protocol ICarsInteractorOutput {
    func rowAdded()
    func rowEdited(at index: Int)
    func rowDeleted(at index: Int)
    
    func dataFiltered()
}

final class CarsInteractor {
    var presenter: ICarsInteractorOutput?
    
    private let data = CarService.mockData()
}

// MARK: - ICarsInteractor

extension CarsInteractor: ICarsInteractor {
    var count: Int {
        data.count
    }
}

extension CarsInteractor {
    func setFilter(by body: Body?) {
        data.filter = body
        
        presenter?.dataFiltered()
    }
    
    func getFilter() -> Body? {
        return data.filter
    }
    
    func append(car: Car) {
        data.append(car: car)
        
        presenter?.rowAdded()
    }
    
    func replace(at index: Int, with car: Car) {
        data.replace(at: index, with: car)
        
        presenter?.rowEdited(at: index)
    }
    
    func remove(at index: Int) {
        data.remove(at: index)
        
        presenter?.rowDeleted(at: index)
    }
    
    func get(at index: Int) -> Car {
        return data.get(at: index)
    }
}
