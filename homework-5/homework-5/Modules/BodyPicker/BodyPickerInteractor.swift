//
//  BodyPickerInteractor.swift
//  homework-5
//
//  Created by Admin on 15.11.2020.
//

protocol IBodyPickerInteractor: AnyObject {}

protocol IBodyPickerInteractorOutput: AnyObject {
    func bodyReceived(_ body: Body?)
}

final class BodyPickerInteractor {
    weak var presenter: IBodyPickerInteractorOutput?
}

// MARK: - IBodyPickerInteractor

extension BodyPickerInteractor: IBodyPickerInteractor {
    func setBody(_ body: Body?) {
        presenter?.bodyReceived(body)
    }
}
