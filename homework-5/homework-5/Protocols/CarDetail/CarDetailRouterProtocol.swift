//
//  CarDetailRouterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarDetailRouterProtocol: AnyObject {    
    func openBodyPickerView(from view: CarDetailViewProtocol, with body: Body?)
    func closeCarDetailView(_ view: CarDetailViewProtocol)
}
