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
}

extension CarsPresenter {
    var isEmpty: Bool {
        return interactor?.isEmpty ?? true
    }
    
    var count: Int {
        return interactor?.count ?? 0
    }
    
    func append(car: Car) {
        interactor?.append(car: car)
    }
    
    func remove(at index: Int) {
        interactor?.remove(at: index)
    }
    
    func get(at index: Int) -> Car? {
        return interactor?.get(at: index)
    }
    
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
}
