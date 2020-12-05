//
//  NewCompanyAssembly.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

enum NewCompanyAssembly {
    static func createNewCompanyNavigationController(
        delegate: INewCompanyPresenterDelegate
    ) -> NewCompanyViewController {
        let viewController = NewCompanyViewController()
        
        let interactor = NewCompanyInteractor()
        let presenter = NewCompanyPresenter()
        let router = NewCompanyRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        presenter.delegate = delegate
        
        return viewController
    }
}
