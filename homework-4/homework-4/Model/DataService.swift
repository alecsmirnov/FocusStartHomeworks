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


// MARK: - Mock Data Object

extension DataService {
    static func mockObject() -> DataService {
        let dataService = DataService()
        
        let record1 = Record(
            title: "Title 1",
            text: "Text Text Text Text Text Text",
            date: Date.random(),
            firstImage: Images.wainCat,
            secondImage: Images.wainCatBouquet
        )
        let record2 = Record(
            title: "Two-line Title Two-line Title Two-line Title",
            text: """
            Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text
            Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text
            Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text
            Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text
            """,
            date: Date.random(),
            firstImage: Images.wainCat,
            secondImage: Images.wainCatBouquet
        )
        let record3 = Record(
            title: "Title 3",
            text: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            firstImage: Images.wainCat,
            secondImage: Images.wainCatBouquet
        )
        let record4 = Record(
            title: "Title 4",
            text: "Text Text Text Text Text Text Text Text Text",
            date: Date.random(),
            firstImage: Images.wainCat,
            secondImage: Images.wainCatBouquet
        )
        let record5 = Record(
            title: "Title 5",
            firstImage: Images.wainCat,
            secondImage: Images.wainCatBouquet
        )
        
        dataService.append(record: record1)
        dataService.append(record: record2)
        dataService.append(record: record3)
        dataService.append(record: record4)
        dataService.append(record: record5)
        
        return dataService
    }
}
