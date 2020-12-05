//
//  EmployeeDetailInteractor.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

protocol IEmployeeDetailInteractor: AnyObject {}
protocol IEmployeeDetailInteractorOutput {}

final class EmployeeDetailInteractor {
    var presenter: IEmployeeDetailInteractorOutput?
}

// MARK: - IEmployeeDetailInteractor

extension EmployeeDetailInteractor: IEmployeeDetailInteractor {}
