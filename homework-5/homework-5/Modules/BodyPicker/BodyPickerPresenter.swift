//
//  BodyPickerPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

final class BodyPickerPresenter: BodyPickerPresenterProtocol {
    weak var view: BodyPickerViewProtocol?
    var router: BodyPickerRouterProtocol?
}

extension BodyPickerPresenter {
    func didPressCloseButton() {
        router?.closeBodyPickerView()
    }
}
