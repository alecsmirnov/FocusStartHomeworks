//
//  CarService.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

class CarService {
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
