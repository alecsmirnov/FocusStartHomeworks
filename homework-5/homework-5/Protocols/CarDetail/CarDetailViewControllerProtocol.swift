//
//  CarDetailViewControllerProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarDetailViewControllerProtocol: CarDetailViewControllerInputProtocol {
    var presenter: CarDetailPresenterProtocol? { get set }
}

protocol CarDetailViewControllerInputProtocol: AnyObject {
    var carToEdit: Car? { get set }
    var bodyToReceive: Body? { get set }
}
