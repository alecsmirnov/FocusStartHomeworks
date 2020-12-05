//
//  EmployeesAssembly.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

enum EmployeesAssembly {
    static func createEmployeesViewController(delegate: IEmployeesPresenterDelegate,
                                              with employees: [Employee]) -> EmployeesViewController {
        let viewController = EmployeesViewController()
        
        let interactor = EmployeesInteractor()
        let presenter = EmployeesPresenter()
        let router = EmployeesRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        presenter.delegate = delegate
        presenter.employees = employees
        
        return viewController
    }
}
