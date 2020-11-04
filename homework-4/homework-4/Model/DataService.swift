//
//  DataService.swift
//  homework-4
//
//  Created by Admin on 04.11.2020.
//

import Foundation

final class DataService {
    // MARK: Properties
    
    var isEmpty: Bool {
        return data.isEmpty
    }
    
    var count: Int {
        return data.count
    }
    
    private var data = [Record]()
}

// MARK: - Public Methods

extension DataService {
    func append(record: Record) {
        data.append(record)
    }
    
    func get(at index: Int) -> Record {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        return data[index]
    }
    
    func remove(at index: Int) -> Record {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        return data.remove(at: index)
    }
    
    func removeAll() {
        data.removeAll()
    }
}
