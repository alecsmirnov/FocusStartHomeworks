//
//  EmployeeDetailAssembly.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

enum EmployeeDetailAssembly {
    static func createEmployeeDetailViewController(delegate: IEmployeeDetailPresenterDelegate,
                                                   with employee: Employee?) -> EmployeeDetailViewController {
        let viewController = EmployeeDetailViewController()
        
        let interactor = EmployeeDetailInteractor()
        let presenter = EmployeeDetailPresenter()
        let router = EmployeeDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        presenter.delegate = delegate
        presenter.employee = employee
        
        return viewController
    }
}
