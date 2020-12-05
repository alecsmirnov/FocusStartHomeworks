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
    
    func didPressAddButton()
    func didSelectRow(at index: Int)
}

protocol IEmployeesPresenterDelegate: AnyObject {
    func iEmployeesPresenter(_ presenter: IEmployeesPresenter, addedNewEmployee employee: Employee)
    func iEmployeesPresenter(_ presenter: IEmployeesPresenter, editEmployee employee: Employee, by index: Int)
    func iEmployeesPresenter(_ presenter: IEmployeesPresenter, deleteEmployeeAt index: Int)
}

final class EmployeesPresenter {
    weak var viewController: IEmployeesViewController?
    var interactor: IEmployeesInteractor?
    var router: IEmployeesRouter?
    
    weak var delegate: IEmployeesPresenterDelegate?
    
    var employees = [Employee]()
    
    private var employeesViewUpdateType = TableViewUpdateType.none
    private var selectedRowIndex: Int?
}

// MARK: - IEmployeesPresenter

extension EmployeesPresenter: IEmployeesPresenter {
    // MARK: Properties

    var count: Int {
        return employees.count
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
        return employees[index]
    }

    func remove(at index: Int) {
        employees.remove(at: index)
        
        viewController?.updateDeletedData(at: index)
        
        delegate?.iEmployeesPresenter(self, deleteEmployeeAt: index)
    }

    func addNewEmployee(_ employee: Employee) {
        employees.append(employee)

        employeesViewUpdateType = .insertNewRow
    }

    func editEmployee(_ employee: Employee) {
        if let index = selectedRowIndex {
            employees[index] = employee

            employeesViewUpdateType = .updateRow(index: index)
        }
    }
    
    func deleteEmployee() {
        if let index = selectedRowIndex {
            employees.remove(at: index)
            
            employeesViewUpdateType = .deleteRow(index: index)
        }
    }

    // MARK: Actions

    func didPressAddButton() {
        router?.openEmployeeDetailViewController(delegate: self, with: nil)
    }

    func didSelectRow(at index: Int) {
        selectedRowIndex = index

        router?.openEmployeeDetailViewController(delegate: self, with: employees[index])
    }
}

// MARK: - IEmployeesInteractorOutput

extension EmployeesPresenter: IEmployeesInteractorOutput {}

// MARK: - IEmployeeDetailPresenterDelegate

extension EmployeesPresenter: IEmployeeDetailPresenterDelegate {
    func iEmployeeDetailPresenter(_ presenter: IEmployeeDetailPresenter, addedNewEmployee employee: Employee) {
        addNewEmployee(employee)
        
        delegate?.iEmployeesPresenter(self, addedNewEmployee: employee)
    }
    
    func iEmployeeDetailPresenter(_ presenter: IEmployeeDetailPresenter, editEmployee employee: Employee) {
        if let index = selectedRowIndex {
            editEmployee(employee)
        
            delegate?.iEmployeesPresenter(self, editEmployee: employee, by: index)
        }
    }
    
    func iEmployeeDetailPresenterDeleteEmployee(_ presenter: IEmployeeDetailPresenter) {
        if let index = selectedRowIndex {
            deleteEmployee()
        
            delegate?.iEmployeesPresenter(self, deleteEmployeeAt: index)
        }
    }
}
