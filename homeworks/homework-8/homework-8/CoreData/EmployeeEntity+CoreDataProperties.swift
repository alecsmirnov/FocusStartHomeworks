//
//  EmployeeEntity+CoreDataProperties.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//
//

import Foundation
import CoreData

extension EmployeeEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeEntity> {
        return NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var age: Int32
    @NSManaged public var post: String
    
    @NSManaged public var workExperience: String?
    @NSManaged public var education: String?
    
    @NSManaged public var company: CompanyEntity?
}

// MARK: - Identifiable

extension EmployeeEntity : Identifiable {}
