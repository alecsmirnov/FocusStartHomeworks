//
//  BodyPickerViewControllerProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol BodyPickerViewControllerProtocol: BodyPickerViewControllerInputProtocol,
                                           BodyPickerViewControllerOutputProtocol {
    var presenter: BodyPickerPresenterProtocol? { get set }
}

protocol BodyPickerViewControllerInputProtocol: AnyObject {
    var selectedBody: Body? { get set }
}

protocol BodyPickerViewControllerOutputProtocol: AnyObject {
    var didSelectBody: BodySelectAction? { get set }
}
