//
//  CarDetailPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

protocol ICarDetailPresenter: AnyObject {
    func viewDidLoad(view: ICarDetailView)
    
    func didPressAddButton(with car: Car)
    func didPressEditButton(with car: Car)
    func didPressDeleteButton()
}

final class CarDetailPresenter {
    weak var view: ICarDetailViewController?
    var interactor: ICarDetailInteractor?
    var router: ICarDetailRouter?
    
    weak var delegate: CarDetailViewControllerDelegate?
    
    private var carToEdit: Car?
}

// MARK: - ICarDetailPresenter

extension CarDetailPresenter: ICarDetailPresenter {
    func didPressAddButton(with car: Car) {
        delegate?.carsViewControllerDelegate(self, addNew: car)
        
        router?.closeCarDetailView()
    }
    
    func didPressEditButton(with car: Car) {
        delegate?.carsViewControllerDelegate(self, edit: car)
        
        router?.closeCarDetailView()
    }
    
    func didPressDeleteButton() {
        delegate?.carsViewControllerDelegateDeleteCar(self)
        
        router?.closeCarDetailView()
    }
    
    func viewDidLoad(view: ICarDetailView) {
        view.setCarToEdit(carToEdit)
        
        view.didSelectBody = { [weak self] body in
            self?.didPressBodyButton(with: body)
        }
    }
}

private extension CarDetailPresenter {
    func didPressBodyButton(with body: Body?) {
        router?.openBodyPickerView(with: body)
    }
}

// MARK: - ICarDetailInteractorOutput

extension CarDetailPresenter: ICarDetailInteractorOutput {
    func carToEditReceived(_ car: Car?) {
        carToEdit = car
    }
}
