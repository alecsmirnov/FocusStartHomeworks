//
//  BodyPickerViewProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

typealias BodyPickerViewProtocol = BodyPickerViewInputProtocol & BodyPickerViewOutputProtocol

protocol BodyPickerViewInputProtocol: AnyObject {
    var selectedBody: Body? { get set }
}

protocol BodyPickerViewOutputProtocol: AnyObject {
    var didSelectBody: BodySelectAction? { get set }
}
