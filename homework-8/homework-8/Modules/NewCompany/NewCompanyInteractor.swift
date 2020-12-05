//
//  NewCompanyInteractor.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

protocol INewCompanyInteractor: AnyObject {}
protocol INewCompanyInteractorOutput: AnyObject {}

final class NewCompanyInteractor {
    weak var presenter: INewCompanyInteractorOutput?
}

// MARK: - INewCompanyInteractor

extension NewCompanyInteractor: INewCompanyInteractor {}
