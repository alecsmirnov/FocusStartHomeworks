//
//  CompanyEntity+CoreDataProperties.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//
//

import Foundation
import CoreData

extension CompanyEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyEntity> {
        return NSFetchRequest<CompanyEntity>(entityName: "CompanyEntity")
    }

    @NSManaged public var name: String
    
    @NSManaged public var employees: NSSet?
}

// MARK: - Generated accessors for employees

extension CompanyEntity {
    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: EmployeeEntity)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: EmployeeEntity)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)
}

// MARK: - Identifiable

extension CompanyEntity : Identifiable {}
