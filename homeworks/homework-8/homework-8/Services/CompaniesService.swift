//
//  CompaniesService.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

import UIKit
import CoreData

final class CompaniesService {
    var isEmpty: Bool {
        return data.isEmpty
    }
    
    var count: Int {
        return data.count
    }
    
    private var data = [CompanyEntity]()
    
    private let managedContext: NSManagedObjectContext

    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()

        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    deinit {
        removeAll()
    }
}

// MARK: - Methods for working with Companies

extension CompaniesService {
    func appendCompany(_ company: Company) {
        let companyEntity = CompanyEntity(context: managedContext)
        
        companyEntity.name = company.name
        
        company.employees.forEach { employee in
            let employeeEntity = EmployeeEntity(context: managedContext)
            employeeEntity.name = employee.name
            employeeEntity.age = Int32(employee.age)
            employeeEntity.post = employee.post
            
            employeeEntity.workExperience = employee.workExperience
            employeeEntity.education = employee.education
            
            employeeEntity.company = companyEntity
            
            companyEntity.addToEmployees(employeeEntity)
        }
        
        data.append(companyEntity)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getCompany(at index: Int) -> Company {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        let companyEntity = data[index]
        
        var employees = [Employee]()
        if let employeesEntities = companyEntity.employees {
            for case let employeeEntity as EmployeeEntity in employeesEntities {
                let employee = Employee(name: employeeEntity.name,
                                        age: Int(employeeEntity.age),
                                        post: employeeEntity.post,
                                        workExperience: employeeEntity.workExperience,
                                        education: employeeEntity.education)
                
                employees.append(employee)
            }
        }
        
        return Company(name: companyEntity.name, employees: employees)
    }
    
    func removeCompany(at index: Int) {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        data.remove(at: index)
        
        let fetchRequest: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()

        do {
            let entities = try managedContext.fetch(fetchRequest)
            let entityObject = entities[index] as NSManagedObject
                
            managedContext.delete(entityObject)
            
            try managedContext.save()
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
}

// MARK: - Methods for working with Employees

extension CompaniesService {
    func appendEmployee(_ employee: Employee, by companyIndex: Int) {
        guard data.indices.contains(companyIndex) else {
            fatalError("index is out of range")
        }
        
        let companyEntity = data[companyIndex]
        
        let employeeEntity = EmployeeEntity(context: managedContext)
        employeeEntity.name = employee.name
        employeeEntity.age = Int32(employee.age)
        employeeEntity.post = employee.post
        
        employeeEntity.workExperience = employee.workExperience
        employeeEntity.education = employee.education
        
        employeeEntity.company = companyEntity
        
        companyEntity.addToEmployees(employeeEntity)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("could not save. \(error), \(error.userInfo)")
        }
    }
    
    func removeEmployee(at index: Int, by companyIndex: Int) {
        guard data.indices.contains(companyIndex),
              let employeesEntityArray = data[companyIndex].employees?.allObjects as? [EmployeeEntity],
              employeesEntityArray.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        let companyEntity = data[companyIndex]
        companyEntity.removeFromEmployees(employeesEntityArray[index])

        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func replaceEmployee(_ employee: Employee, at index: Int, by companyIndex: Int) {
        guard data.indices.contains(companyIndex),
              let employeesEntityArray = data[companyIndex].employees?.allObjects as? [EmployeeEntity],
              employeesEntityArray.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        let employeeEntity = employeesEntityArray[index]
        employeeEntity.name = employee.name
        employeeEntity.age = Int32(employee.age)
        employeeEntity.post = employee.post
        
        employeeEntity.workExperience = employee.workExperience
        employeeEntity.education = employee.education

        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
}

// MARK: - Private Methods

private extension CompaniesService {
    func removeAll() {
        data.removeAll()
        
        let fetchRequest: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()

        do {
            let entities = try managedContext.fetch(fetchRequest)

            for entity in entities {
                let entityObject = entity as NSManagedObject

                managedContext.delete(entityObject)
            }
            
            try managedContext.save()
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
}
