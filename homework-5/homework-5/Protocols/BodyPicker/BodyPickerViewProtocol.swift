//
//  BodyPickerViewControllerProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol BodyPickerViewProtocol: AnyObject {    
    var selectedBody: Body? { get set }
    var didSelectBody: BodySelectAction? { get set }
}
