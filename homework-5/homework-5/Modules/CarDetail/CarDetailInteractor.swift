//
//  CarDetailInteractor.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

protocol CarDetailInteractorProtocol: AnyObject {
    var presenter: CarDetailPresenterProtocol? { get set }
}

final class CarDetailInteractor: CarDetailInteractorProtocol {
    var presenter: CarDetailPresenterProtocol?
}
