//
//  NewCompanyAssembly.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

enum NewCompanyAssembly {
    static func createNewCompanyViewController(
        delegate: INewCompanyPresenterDelegate
    ) -> NewCompanyViewController {
        let viewController = NewCompanyViewController()
        
        let presenter = NewCompanyPresenter()
        let router = NewCompanyRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        presenter.viewController = viewController
        presenter.router = router
        
        presenter.delegate = delegate
        
        return viewController
    }
}
