//
//  CarsRouterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarsRouterProtocol: AnyObject {    
    func openFilterView(from view: CarsViewProtocol, with body: Body?)
    func openCarDetailView(from view: CarsViewProtocol, with car: Car?)
}

extension CarsRouterProtocol {
    func openFilterView(from view: CarsViewProtocol) {
        openFilterView(from: view, with: nil)
    }
    
    func openCarDetailView(from view: CarsViewProtocol) {
        openCarDetailView(from: view, with: nil)
    }
}
