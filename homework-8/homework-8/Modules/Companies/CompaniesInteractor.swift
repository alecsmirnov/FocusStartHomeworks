//
//  CompaniesInteractor.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

protocol ICompaniesInteractor: AnyObject {
    var count: Int { get }
    
    func createCompany(name: String)
    func appendCompany(_ company: Company)
    func removeCompany(at index: Int)
    
    func getCompany(at index: Int) -> Company
    
    func appendEmployee(_ employee: Employee, by index: Int)
    func replaceEmployee(_ employee: Employee, at index: Int, by companyIndex: Int)
    func removeEmployee(at index: Int, by companyIndex: Int)
}

protocol ICompaniesInteractorOutput {}

final class CompaniesInteractor {
    var presenter: ICompaniesInteractorOutput?
    
    private let data = CompaniesService()
}

// MARK: - ICarsInteractor

extension CompaniesInteractor: ICompaniesInteractor {
    var count: Int {
        data.count
    }
}

// MARK: - Methods for working with Companies

extension CompaniesInteractor {
    func createCompany(name: String) {
        let company = Company(name: name, employees: [])
        
        data.appendCompany(company)
    }
    
    func appendCompany(_ company: Company) {
        data.appendCompany(company)
    }
    
    func removeCompany(at index: Int) {
        data.removeCompany(at: index)
    }
    
    func getCompany(at index: Int) -> Company {
        return data.getCompany(at: index)
    }
}

// MARK: - Methods for working with Employees

extension CompaniesInteractor {
    func appendEmployee(_ employee: Employee, by index: Int) {
        data.appendEmployee(employee, by: index)
    }
    
    func replaceEmployee(_ employee: Employee, at index: Int, by companyIndex: Int) {
        data.replaceEmployee(employee, at: index, by: companyIndex)
    }
    
    func removeEmployee(at index: Int, by companyIndex: Int) {
        data.removeEmployee(at: index, by: companyIndex)
    }
}
