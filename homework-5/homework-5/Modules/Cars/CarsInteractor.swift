//
//  CarsInteractor.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

final class CarsInteractor: CarsInteractorProtocol {
    var presenter: CarsPresenterProtocol?
    
    private let data = CarService.mockData()
    
//    var isEmpty: Bool {
//        return data.isEmpty
//    }
//
//    var count: Int {
//        return data.count
//    }
//
//    func append(car: Car) {
//        data.append(car: car)
//    }
//
//    func get(at index: Int) -> Car {
//        return data.get(at: index)
//    }
    
    func getData() -> CarService {
        return data
    }
}
