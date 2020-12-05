//
//  EmployeesRouter.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

protocol IEmployeesRouter: AnyObject {
    func openEmployeeDetailViewController(with employee: Employee?)
}

final class EmployeesRouter {
    private weak var viewController: EmployeesViewController?
    
    init(viewController: EmployeesViewController) {
        self.viewController = viewController
    }
}

// MARK: - IEmployeesRouter

extension EmployeesRouter: IEmployeesRouter {
    func openEmployeeDetailViewController(with employee: Employee?) {
        
    }
}
