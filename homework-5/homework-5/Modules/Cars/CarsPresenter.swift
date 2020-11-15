//
//  CarsPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

final class CarsPresenter: CarsPresenterProtocol {
    weak var view: CarsViewProtocol?
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
}

extension CarsPresenter {
    func append(car: Car) {
        interactor?.append(car: car)
    }
    
    func replace(at index: Int, with car: Car) {
        interactor?.replace(at: index, with: car)
    }
    
    func remove(at index: Int) {
        interactor?.remove(at: index)
    }
    
    func get(at index: Int) -> Car? {
        return interactor?.get(at: index)
    }
    
    func setFilter(by body: Body?) {
        if let body = body {
            interactor?.filter(by: body)
        } else {
            interactor?.filterReset()
        }
    }
}

extension CarsPresenter {
    func didPressFilterButton(with body: Body?) {
        if let view = view {
            router?.openFilterView(from: view, with: body)
        }
    }
    
    func didPressAddButton() {
        if let view = view {
            router?.openCarDetailView(from: view)
        }
    }
    
    func didSelectRow(with car: Car) {
        if let view = view {
            router?.openCarDetailView(from: view, with: car)
        }
    }
}
