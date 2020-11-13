//
//  BodyPickerInteractor.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

protocol BodyPickerInteractorProtocol: AnyObject {
    var presenter: BodyPickerPresenterProtocol? { get set }
}

final class BodyPickerInteractor: BodyPickerInteractorProtocol {
    var presenter: BodyPickerPresenterProtocol?
}
