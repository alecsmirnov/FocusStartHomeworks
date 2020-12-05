//
//  CompaniesInteractor.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

protocol ICompaniesInteractor: AnyObject {
    var count: Int { get }
    
    func createCompany(name: String)
    func append(company: Company)
    func replace(at index: Int, with company: Company)
    func remove(at index: Int)
    
    func get(at index: Int) -> Company
}

protocol ICompaniesInteractorOutput {}

final class CompaniesInteractor {
    var presenter: ICompaniesInteractorOutput?
    
    private let data = CompaniesService()
}

// MARK: - ICarsInteractor

extension CompaniesInteractor: ICompaniesInteractor {
    // MARK: Properties
    
    var count: Int {
        data.count
    }
    
    // MARK: Methods
    
    func createCompany(name: String) {
        let company = Company(name: name, employees: [])
        
        append(company: company)
    }
    
    func append(company: Company) {
        data.append(company: company)
    }
    
    func replace(at index: Int, with company: Company) {
        data.replaceCompany(at: index, with: company)
    }
    
    func remove(at index: Int) {
        data.removeCompany(at: index)
    }
    
    func get(at index: Int) -> Company {
        return data.getCompany(at: index)
    }
}
