//
//  BodyPickerPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

final class BodyPickerPresenter: BodyPickerPresenterProtocol {
    weak var viewController: BodyPickerViewControllerProtocol?
    
    var interactor: BodyPickerInteractorProtocol?
    var router: BodyPickerRouterProtocol?
}

extension BodyPickerPresenter {
    func didSelectBody(_ body: Body?) {
        if let viewController = viewController {
            router?.closeBodyPickerViewController(viewController)
        }
    }
}
