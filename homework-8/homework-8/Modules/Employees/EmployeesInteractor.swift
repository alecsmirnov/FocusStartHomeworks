//
//  EmployeesInteractor.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

protocol IEmployeesInteractor: AnyObject {}
protocol IEmployeesInteractorOutput {}

final class EmployeesInteractor {
    var presenter: IEmployeesInteractorOutput?
}

// MARK: - IEmployeesInteractor

extension EmployeesInteractor: IEmployeesInteractor {}
