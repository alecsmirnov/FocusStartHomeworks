//
//  EmployeeDetailRouter.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

protocol IEmployeeDetailRouter: AnyObject {
    func closeEmployeeDetailViewController()
}

final class EmployeeDetailRouter {
    private weak var viewController: EmployeeDetailViewController?
    
    init(viewController: EmployeeDetailViewController) {
        self.viewController = viewController
    }
}

// MARK: - IEmployeeDetailRouter

extension EmployeeDetailRouter: IEmployeeDetailRouter {
    func closeEmployeeDetailViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
