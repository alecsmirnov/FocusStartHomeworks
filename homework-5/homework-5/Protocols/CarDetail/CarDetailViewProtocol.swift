//
//  CarDetailViewProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarDetailViewProtocol: AnyObject {
    var carToEdit: Car? { get set }
    var bodyToReceive: Body? { get set }
    var didSelectBody: BodySelectAction? { get set }
}
