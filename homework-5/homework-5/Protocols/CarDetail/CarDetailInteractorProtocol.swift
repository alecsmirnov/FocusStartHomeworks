//
//  CarDetailInteractorProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarDetailInteractorProtocol: AnyObject {
    var presenter: CarDetailPresenterProtocol? { get set }
}
