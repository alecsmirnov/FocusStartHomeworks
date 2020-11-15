//
//  CarsViewControllerProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarsViewControllerProtocol: AnyObject {   
    var filter: Body? { get set }
    
    init(presenter: CarsPresenterProtocol)
}
