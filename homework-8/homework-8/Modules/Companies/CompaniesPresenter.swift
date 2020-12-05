//
//  CompaniesPresenter.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

protocol ICompaniesPresenter: AnyObject {
    var count: Int { get }
    
    func viewDidAppear()
    
    func get(at index: Int) -> Company?
    func remove(at index: Int)
    func addNewCompany(_ company: Company)
    
    func didPressAddButton()
    func didSelectRow(at index: Int)
}

final class CompaniesPresenter {
    weak var viewController: ICompaniesViewController?
    var interactor: ICompaniesInteractor?
    var router: ICompaniesRouter?
    
    private var companiesViewUpdateType = TableViewUpdateType.none
    private var selectedRowIndex: Int?
}

// MARK: - ICompaniesPresenter

extension CompaniesPresenter: ICompaniesPresenter {
    // MARK: Properties
    
    var count: Int {        
        return interactor?.count ?? 0
    }

    // MARK: Lifecycle
    
    func viewDidAppear() {
        switch companiesViewUpdateType {
        case .insertNewRow: viewController?.updateAddingData()
        case .updateRow(let index): viewController?.reloadData(at: index)
        case .deleteRow(let index): viewController?.updateDeletedData(at: index)
        case .none: break
        }
        
        companiesViewUpdateType = .none
    }
    
    // MARK: Input

    func get(at index: Int) -> Company? {
        return interactor?.getCompany(at: index)
    }
    
    func remove(at index: Int) {
        interactor?.removeCompany(at: index)
    }
    
    func addNewCompany(_ company: Company) {
        interactor?.appendCompany(company)
        
        companiesViewUpdateType = .insertNewRow
    }

    // MARK: Actions
    
    func didPressAddButton() {
        router?.openNewCompanyViewController(delegate: self)
    }
    
    func didSelectRow(at index: Int) {
        selectedRowIndex = index
        
        if let company = interactor?.getCompany(at: index) {
            router?.openEmployeesViewController(delegate: self, with: company.employees)
        }
    }
}

// MARK: - ICarsInteractorOutput

extension CompaniesPresenter: ICompaniesInteractorOutput {}

// MARK: - INewCompanyPresenterDelegate

extension CompaniesPresenter: INewCompanyPresenterDelegate {
    func iNewCompanyPresenter(_ presenter: INewCompanyPresenter, addedNewCompany companyName: String) {
        interactor?.createCompany(name: companyName)
        
        companiesViewUpdateType = .insertNewRow
    }
}

// MARK: - IEmployeesPresenterDelegate

extension CompaniesPresenter: IEmployeesPresenterDelegate {
    func iEmployeesPresenter(_ presenter: IEmployeesPresenter, addedNewEmployee employee: Employee) {
        if let companyIndex = selectedRowIndex {
            interactor?.appendEmployee(employee, by: companyIndex)
            
            companiesViewUpdateType = .updateRow(index: companyIndex)
        }
    }
    
    func iEmployeesPresenter(_ presenter: IEmployeesPresenter, editEmployee employee: Employee, by index: Int) {
        if let companyIndex = selectedRowIndex {
            interactor?.replaceEmployee(employee, at: index, by: companyIndex)
            
            companiesViewUpdateType = .updateRow(index: index)
        }
    }
    
    func iEmployeesPresenter(_ presenter: IEmployeesPresenter, deleteEmployeeAt index: Int) {
        if let companyIndex = selectedRowIndex {
            interactor?.removeEmployee(at: index, by: companyIndex)
            
            companiesViewUpdateType = .updateRow(index: companyIndex)
        }
    }
}
