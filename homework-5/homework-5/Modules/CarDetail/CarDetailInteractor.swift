//
//  CarDetailInteractor.swift
//  homework-5
//
//  Created by Admin on 15.11.2020.
//

protocol ICarDetailInteractor: AnyObject {}

protocol ICarDetailInteractorOutput: AnyObject {
    func carToEditReceived(_ car: Car?)
}

final class CarDetailInteractor {
    weak var presenter: ICarDetailInteractorOutput?
}

// MARK: - ICarDetailInteractor

extension CarDetailInteractor: ICarDetailInteractor {
    func setCarToEdit(_ car: Car?) {
        presenter?.carToEditReceived(car)
    }
}
