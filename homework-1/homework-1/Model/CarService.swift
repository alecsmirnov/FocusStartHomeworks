//
//  CarService.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import Foundation

class CarService {
    var isEmpty: Bool {
        return data.isEmpty
    }
    
    var count: Int {
        return data.count
    }
    
    private var data: [Car] = []
    
    func append(car: Car) {
        data.append(car)
    }
    
    func get(at index: Int) -> Car {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        return data[index]
    }
    
    func remove(at index: Int) {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        data.remove(at: index)
    }
    
    func replace(at index: Int, with car: Car) {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        data[index] = car
    }
    
    func removeAll() {
        data.removeAll()
    }
    
    deinit {
        removeAll()
    }
}
