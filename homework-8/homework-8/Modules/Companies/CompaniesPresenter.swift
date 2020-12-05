//
//  CompaniesPresenter.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

protocol ICompaniesPresenter: AnyObject {
    var count: Int { get }
    
    func viewDidAppear(view: ICompaniesView)
    
    func get(at index: Int) -> Company?
    func remove(at index: Int)
    func addNewCompany(_ company: Company)
    func editCompany(_ company: Company)
    func deleteCompany()
    
    func didPressAddButton()
    func didSelectRow(at index: Int)
}

final class CompaniesPresenter {
    weak var viewController: ICompaniesViewController?
    var interactor: ICompaniesInteractor?
    var router: ICompaniesRouter?
    
    private enum CompaniesViewUpdateType {
        case insertNewRow
        case updateRow(index: Int)
        case deleteRow(index: Int)
        case none
    }
    
    private var companiesViewUpdateType = CompaniesViewUpdateType.none
    
    private var selectedRowIndex: Int?
}

// MARK: - ICarsPresenter

extension CompaniesPresenter: ICompaniesPresenter {
    // MARK: Properties
    
    var count: Int {        
        return interactor?.count ?? 0
    }

    // MARK: Lifecycle
    
    func viewDidAppear(view: ICompaniesView) {
        switch companiesViewUpdateType {
        case .insertNewRow: view.insertNewRow()
        case .updateRow(let index): view.reloadRow(at: index)
        case .deleteRow(let index): view.deleteRow(at: index)
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
    
    func deleteCompany() {
        if let index = selectedRowIndex {
            interactor?.remove(at: index)
            
            companiesViewUpdateType = .deleteRow(index: index)
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
        viewController?.updateAddingData()
    }
}
