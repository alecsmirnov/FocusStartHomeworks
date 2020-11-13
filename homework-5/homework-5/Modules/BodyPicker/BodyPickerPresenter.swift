//
//  BodyPickerPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

protocol BodyPickerPresenterProtocol: AnyObject {
    var viewController: BodyPickerViewControllerProtocol? { get set }
    
    var interactor: BodyPickerInteractorProtocol? { get set }
    var router: BodyPickerRouterProtocol? { get set }
    
    func didSelectBody(_ body: Body?)
}

final class BodyPickerPresenter: BodyPickerPresenterProtocol {
    weak var viewController: BodyPickerViewControllerProtocol?
    
    var interactor: BodyPickerInteractorProtocol?
    var router: BodyPickerRouterProtocol?
    
    func didSelectBody(_ body: Body?) {
        if let viewController = viewController {
            router?.closeBodyPickerViewController(viewController)
        }
    }
}
