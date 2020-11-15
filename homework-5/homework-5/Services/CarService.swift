//
//  CarService.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import UIKit
import CoreData

final class CarService {
    var isEmpty: Bool {
        return filteredData.isEmpty
    }
    
    var count: Int {
        return filteredData.count
    }
    
    var filter: Body? {
        didSet { setFilter(by: filter) }
    }
    
    private var filteredData = [CarEntity]()
    private var tempData = [CarEntity]()
    
    private var managedContext: NSManagedObjectContext

    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()

        do {
            filteredData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func append(car: Car) {
        let carEntity = CarEntity(context: managedContext)
        
        carEntity.manufacturer = car.manufacturer
        carEntity.model = car.model
        
        if let yearOfIssue = car.yearOfIssue {
            carEntity.yearOfIssue = NSNumber(value: yearOfIssue)
        }
        
        carEntity.body = car.body.rawValue
        carEntity.carNumber = car.carNumber
        
        filteredData.append(carEntity)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("could not save. \(error), \(error.userInfo)")
        }
    }
    
    func get(at index: Int) -> Car {
        guard filteredData.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        guard let body = Body(rawValue: filteredData[index].body) else {
            fatalError("wrong body type")
        }
        
        return Car(manufacturer: filteredData[index].manufacturer,
                   model: filteredData[index].model,
                   body: body,
                   yearOfIssue: filteredData[index].yearOfIssue?.intValue,
                   carNumber: filteredData[index].carNumber)
    }
    
    func remove(at index: Int) {
        guard filteredData.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        filteredData.remove(at: index)
        
        let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()

        do {
            let entities = try managedContext.fetch(fetchRequest)
            let entityObject = entities[index] as NSManagedObject
                
            managedContext.delete(entityObject)
                
            try managedContext.save()
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func replace(at index: Int, with car: Car) {
        guard filteredData.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        filteredData[index].manufacturer = car.manufacturer
        filteredData[index].model = car.model
        
        if let yearOfIssue = car.yearOfIssue {
            filteredData[index].yearOfIssue = NSNumber(value: yearOfIssue)
        }
        
        filteredData[index].body = car.body.rawValue
        filteredData[index].carNumber = car.carNumber
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func removeAll() {
        filteredData.removeAll()
        tempData.removeAll()
        
        let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()

        do {
            let entities = try managedContext.fetch(fetchRequest)

            for entity in entities {
                let entityObject = entity as NSManagedObject

                managedContext.delete(entityObject)
            }
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    deinit {
        removeAll()
    }
}

// MARK: - Private Methods

extension CarService {
    func setFilter(by body: Body?) {
        if let body = body {
            if tempData.isEmpty {
                tempData = filteredData
            } else {
                tempData += filteredData
            }
            
            filteredData = tempData.filter { $0.body == body.rawValue }
            tempData = tempData.filter { !filteredData.contains($0) }
        } else {
            filteredData += tempData
            tempData.removeAll()
        }
    }
}

// MARK: - Mock Data

extension CarService {
    static func mockData() -> CarService {
        let carService = CarService()
        
        if carService.isEmpty {
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
        }
        
        return carService
    }
}
