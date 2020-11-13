//
//  BodyPickerPresenterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol BodyPickerPresenterProtocol: BodyPickerPresenterInputProtocol {
    var viewController: BodyPickerViewControllerProtocol? { get set }
    
    var interactor: BodyPickerInteractorProtocol? { get set }
    var router: BodyPickerRouterProtocol? { get set }
}

protocol BodyPickerPresenterInputProtocol: AnyObject {
    func didPressCloseButton()
}
