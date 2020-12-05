//
//  EmployeesPresenter.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

protocol IEmployeesPresenter: AnyObject {
    var count: Int { get }
    
    func viewDidAppear()
    
    func get(at index: Int) -> Employee?
    func remove(at index: Int)
    func addNewEmployee(_ employee: Employee)
    func editEmployee(_ employee: Employee)
    func deleteEmployee()
    
    func didPressAddButton()
    func didSelectRow(at index: Int)
}

final class EmployeesPresenter {
    weak var viewController: IEmployeesViewController?
    var interactor: IEmployeesInteractor?
    var router: IEmployeesRouter?
    
    var employees: [Employee]?
    
    private var employeesViewUpdateType = TableViewUpdateType.none
    private var selectedRowIndex: Int?
}

// MARK: - ICarsPresenter

extension EmployeesPresenter: IEmployeesPresenter {
    // MARK: Properties

    var count: Int {
        return employees?.count ?? 0
    }

    // MARK: Lifecycle

    func viewDidAppear() {
        switch employeesViewUpdateType {
        case .insertNewRow: viewController?.updateAddingData()
        case .updateRow(let index): viewController?.reloadData(at: index)
        case .deleteRow(let index): viewController?.updateDeletedData(at: index)
        case .none: break
        }

        employeesViewUpdateType = .none
    }

    // MARK: Input

    func get(at index: Int) -> Employee? {
        return employees?[index]
    }

    func remove(at index: Int) {
        employees?.remove(at: index)
    }

    func addNewEmployee(_ employee: Employee) {
        employees?.append(employee)

        employeesViewUpdateType = .insertNewRow
    }

    func editEmployee(_ employee: Employee) {
        if let index = selectedRowIndex {
            employees?[index] = employee

            employeesViewUpdateType = .updateRow(index: index)
        }
    }

    func deleteEmployee() {
        if let index = selectedRowIndex {
            employees?.remove(at: index)

            employeesViewUpdateType = .deleteRow(index: index)
        }
    }

    // MARK: Actions

    func didPressAddButton() {
        //router?.openNewCompanyViewController(delegate: self)
    }

    func didSelectRow(at index: Int) {
        selectedRowIndex = index

        if let employee = employees?[index] {
            //router?.openEmployeesViewController(with: <#T##[Employee]?#>)
        }
    }
}

// MARK: - IEmployeesInteractorOutput

extension EmployeesPresenter: IEmployeesInteractorOutput {}

//// MARK: - INewCompanyPresenterDelegate
//
//extension EmployeesPresenter: INewCompanyPresenterDelegate {
//    func iNewCompanyPresenter(_ presenter: INewCompanyPresenter, addedNewCompany companyName: String) {
//        interactor?.createCompany(name: companyName)
//
//        employeesViewUpdateType = .insertNewRow
//    }
//}
