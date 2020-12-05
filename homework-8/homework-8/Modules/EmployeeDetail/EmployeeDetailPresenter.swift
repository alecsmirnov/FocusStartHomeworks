//
//  EmployeeDetailPresenter.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

protocol IEmployeeDetailPresenter: AnyObject {
    func viewWillAppear()
    
    func didPressAddButton(with employee: Employee?)
    func didPressEditButton(with employee: Employee?)
    func didPressDeleteButton()
}

protocol IEmployeeDetailPresenterDelegate: AnyObject {
    func iEmployeeDetailPresenter(_ presenter: IEmployeeDetailPresenter, addedNewEmployee employee: Employee)
    func iEmployeeDetailPresenter(_ presenter: IEmployeeDetailPresenter, editEmployee employee: Employee)
    func iEmployeeDetailPresenterDeleteEmployee(_ presenter: IEmployeeDetailPresenter)
}

final class EmployeeDetailPresenter {
    weak var viewController: IEmployeeDetailViewController?
    var router: IEmployeeDetailRouter?
    
    weak var delegate: IEmployeeDetailPresenterDelegate?
    
    var employee: Employee?
}

// MARK: - IEmployeeDetailPresenter

extension EmployeeDetailPresenter: IEmployeeDetailPresenter {
    // MARK: Methods
    
    func viewWillAppear() {
        if let employee = employee {
            viewController?.setEmployee(employee)
            viewController?.setupEditAppearance()
        } else {
            viewController?.setupAddAppearance()
        }
    }
    
    func didPressAddButton(with employee: Employee?) {
        if let employee = employee {
            delegate?.iEmployeeDetailPresenter(self, addedNewEmployee: employee)
            
            router?.closeEmployeeDetailViewController()
        } else {
            viewController?.showAlertMessage()
        }
    }
    
    func didPressEditButton(with employee: Employee?) {
        if let employee = employee {
            delegate?.iEmployeeDetailPresenter(self, editEmployee: employee)
            
            router?.closeEmployeeDetailViewController()
        } else {
            viewController?.showAlertMessage()
        }
    }
    
    func didPressDeleteButton() {
        delegate?.iEmployeeDetailPresenterDeleteEmployee(self)
        
        router?.closeEmployeeDetailViewController()
    }
}
