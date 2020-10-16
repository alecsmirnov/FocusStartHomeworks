//
//  CarService.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import Foundation

class CarService {
    var isEmpty: Bool {
        return filteredData.isEmpty
    }
    
    var count: Int {
        return filteredData.count
    }
    
    private var filteredData: [Car] = []
    private var data: [Car] = []
    
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
        filteredData += data
        data.removeAll()
    }
    
    func filter(by body: Body) {
        if data.isEmpty {
            data = filteredData
        }
        else {
            data += filteredData
        }
        
        filteredData = data.filter { $0.body == body }
        data = data.filter { !filteredData.contains($0) }
    }
    
    func removeAll() {
        filteredData.removeAll()
        data.removeAll()
    }
    
    deinit {
        removeAll()
    }
}
