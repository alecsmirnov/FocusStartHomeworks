//
//  CompaniesRouter.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

protocol ICompaniesRouter: AnyObject {
    func openEmployeesViewController(with employees: [Employee]?)
    func openNewCompanyViewController(delegate: INewCompanyPresenterDelegate)
}

final class CompaniesRouter {
    private weak var viewController: CompaniesViewController?
    
    init(viewController: CompaniesViewController) {
        self.viewController = viewController
    }
}

// MARK: - ICarsRouter

extension CompaniesRouter: ICompaniesRouter {
    func openEmployeesViewController(with employees: [Employee]?) {
        
    }
    
    func openNewCompanyViewController(delegate: INewCompanyPresenterDelegate) {
        let newCompanyViewController = NewCompanyAssembly.createNewCompanyViewController(delegate: delegate)
        
        viewController?.navigationController?.pushViewController(newCompanyViewController, animated: true)
    }
}
