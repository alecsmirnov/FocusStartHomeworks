//
//  CarDetailViewProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

typealias CarDetailViewProtocol = CarDetailViewInputProtocol & CarDetailViewOutputProtocol

protocol CarDetailViewInputProtocol: AnyObject {
    var carToEdit: Car? { get set }
    var bodyToReceive: Body? { get set }
}

protocol CarDetailViewOutputProtocol: AnyObject {
    var didSelectBody: BodySelectAction? { get set }
}
