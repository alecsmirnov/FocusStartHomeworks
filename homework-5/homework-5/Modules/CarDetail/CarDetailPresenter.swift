//
//  CarDetailPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

final class CarDetailPresenter: CarDetailPresenterProtocol {
    weak var view: CarDetailViewProtocol?
    var router: CarDetailRouterProtocol?
}

extension CarDetailPresenter {
    func didPressBodyButton(with body: Body?) {
        if let view = view {
            router?.openBodyPickerView(from: view, with: body)
        }
    }
    
    func didPressCloseButton() {
        if let view = view {
            router?.closeCarDetailView(view)
        }
    }
}
