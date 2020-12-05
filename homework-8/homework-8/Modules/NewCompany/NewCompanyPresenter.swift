//
//  NewCompanyPresenter.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

protocol INewCompanyPresenter: AnyObject {
    func didPressAddButton(with name: String?)
}

protocol INewCompanyPresenterDelegate: AnyObject {
    func iNewCompanyPresenter(_ presenter: INewCompanyPresenter, addedNewCompany companyName: String)
}

final class NewCompanyPresenter {
    weak var viewController: INewCompanyViewController?
    var interactor: INewCompanyInteractor?
    var router: INewCompanyRouter?
    
    weak var delegate: INewCompanyPresenterDelegate?
}

// MARK: - INewCompanyPresenter

extension NewCompanyPresenter: INewCompanyPresenter {
    // MARK: Methods
    
    func didPressAddButton(with name: String?) {
        if let name = name {
            delegate?.iNewCompanyPresenter(self, addedNewCompany: name)
            
            router?.closeNewCompanyViewController()
        } else {
            viewController?.showAlertMessage()
        }
    }
}

// MARK: - ICarDetailInteractorOutput

extension NewCompanyPresenter: INewCompanyInteractorOutput {}
