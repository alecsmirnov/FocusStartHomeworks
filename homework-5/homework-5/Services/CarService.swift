//
//  CarService.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

final class CarService {
    var isEmpty: Bool {
        return filteredData.isEmpty
    }
    
    var count: Int {
        return filteredData.count
    }
    
    private var filteredData = [Car]()
    private var tempData = [Car]()
    
    func append(car: Car) {
        filteredData.append(car)
    }
    
    func get(at index: Int) -> Car {
        guard filteredData.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        return filteredData[index]
    }
    
    func remove(at index: Int) {
        guard filteredData.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        filteredData.remove(at: index)
    }
    
    func replace(at index: Int, with car: Car) {
        guard filteredData.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        filteredData[index] = car
    }
    
    func filterReset() {
        filteredData += tempData
        tempData.removeAll()
    }
    
    func filter(by body: Body) {
        if tempData.isEmpty {
            tempData = filteredData
        } else {
            tempData += filteredData
        }
        
        filteredData = tempData.filter { $0.body == body }
        tempData = tempData.filter { !filteredData.contains($0) }
    }
    
    func removeAll() {
        filteredData.removeAll()
        tempData.removeAll()
    }
    
    deinit {
        removeAll()
    }
}

// MARK: - Mock Data

extension CarService {
    static func mockData() -> CarService {
        let carService = CarService()
        
        let car1 = Car(
            manufacturer: "Ford",
            model: "Shelby GT500",
            body: Body.coupe,
            yearOfIssue: 2001,
            carNumber: "A000TA"
        )
        let car2 = Car(
            manufacturer: "Porsche",
            model: "911",
            body: Body.cabriolet,
            yearOfIssue: 2016,
            carNumber: "B023BA"
        )
        let car3 = Car(
            manufacturer: "Lexus",
            model: "LX 570",
            body: Body.pickup,
            yearOfIssue: 2020,
            carNumber: "M294AK"
        )

        carService.append(car: car1)
        carService.append(car: car2)
        carService.append(car: car3)
        
        return carService
    }
}
