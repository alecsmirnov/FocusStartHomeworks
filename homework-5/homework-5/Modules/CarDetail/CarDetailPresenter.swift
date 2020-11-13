//
//  CarDetailPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

final class CarDetailPresenter: CarDetailPresenterProtocol {
    weak var viewController: CarDetailViewControllerProtocol?
    
    var interactor: CarDetailInteractorProtocol?
    var router: CarDetailRouterProtocol?
}

extension CarDetailPresenter {
    func didPressBodyButton(with body: Body?) {
        if let viewController = viewController {
            router?.openBodyPickerViewController(from: viewController, with: body)
        }
    }
    
    func didPressCloseButton() {
        if let viewController = viewController {
            router?.closeCarDetailViewController(viewController)
        }
    }
}
