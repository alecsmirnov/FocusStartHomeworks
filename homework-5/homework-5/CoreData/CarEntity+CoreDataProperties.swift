//
//  CarEntity+CoreDataProperties.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//
//

import Foundation
import CoreData

extension CarEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }

    @NSManaged public var manufacturer: String
    @NSManaged public var model: String
    @NSManaged public var body: String
    @NSManaged public var yearOfIssue: NSNumber?
    @NSManaged public var carNumber: String?
}
