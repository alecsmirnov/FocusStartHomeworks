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
    func editCompany(_ company: Company)
    
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

// MARK: - ICarsPresenter

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
        return interactor?.get(at: index)
    }
    
    func remove(at index: Int) {
        interactor?.remove(at: index)
    }
    
    func addNewCompany(_ company: Company) {
        interactor?.append(company: company)
        
        companiesViewUpdateType = .insertNewRow
    }
    
    func editCompany(_ company: Company) {
        if let index = selectedRowIndex {
            interactor?.replace(at: index, with: company)
            
            companiesViewUpdateType = .updateRow(index: index)
        }
    }

    // MARK: Actions
    
    func didPressAddButton() {
        router?.openNewCompanyViewController(delegate: self)
    }
    
    func didSelectRow(at index: Int) {
        selectedRowIndex = index
        
        if let company = interactor?.get(at: index) {
            //router?.openEmployeesViewController(with: <#T##[Employee]?#>)
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

extension CompaniesPresenter {
    
}
