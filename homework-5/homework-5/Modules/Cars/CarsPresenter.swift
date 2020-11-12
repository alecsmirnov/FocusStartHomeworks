//
//  CarsPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

final class CarsPresenter: CarsPresenterProtocol {
    weak var viewController: CarsViewControllerProtocol?
    
    var interactor: CarsInteractorProtocol?
    var router: CarsRouterProtocol?
    
    func didPressFilterButton(with body: Body?) {
        if let viewController = viewController {
            router?.openFilterViewController(from: viewController, with: body)
        }
    }
    
    func didPressAddButton() {
        if let viewController = viewController {
            router?.openCarDetailViewController(from: viewController)
        }
    }
    
    func didSelectRow(with car: Car) {
        if let viewController = viewController {
            router?.openCarDetailViewController(from: viewController, with: car)
        }
    }
    
    func setData() {
        viewController?.data = interactor?.getData()
    }
}
