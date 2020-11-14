//
//  CarDetailViewControllerProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarDetailViewControllerProtocol: AnyObject {
    var presenter: CarDetailPresenterProtocol? { get set }
    
    var delegate: CarDetailViewControllerDelegate? { get set }
    
    var carToEdit: Car? { get set }
    var bodyToReceive: Body? { get set }
}
