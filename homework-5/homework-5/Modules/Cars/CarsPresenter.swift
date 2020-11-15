//
//  CarsPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

protocol ICarsPresenter: AnyObject {
    var count: Int { get }
    var filter: Body? { get set }
    
    func viewDidLoad(view: ICarsView)
    func viewDidAppear()
    
    func append(car: Car)
    func replace(at index: Int, with car: Car)
    func remove(at index: Int)
    func get(at index: Int) -> Car?
    
    func didPressFilterButton(with body: Body?)
    func didPressAddButton()
    func didSelectRow(with car: Car)
}

final class CarsPresenter {
    weak var view: ICarsViewController?
    var interactor: ICarsInteractor?
    var router: ICarsRouter?
}

// MARK: - ICarsPresenter

extension CarsPresenter: ICarsPresenter {
    var count: Int {
        return interactor?.count ?? 0
    }
    
    var filter: Body? {
        get { interactor?.getFilter() }
        set { interactor?.setFilter(by: newValue) }
    }
}

extension CarsPresenter {
    func viewDidLoad(view: ICarsView) {
        
    }
    
    func viewDidAppear() {
        
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
}

extension CarsPresenter {
    func didPressFilterButton(with body: Body?) {
        router?.openFilterView(with: body)
    }
    
    func didPressAddButton() {
        router?.openCarDetailView()
    }
    
    func didSelectRow(with car: Car) {
        router?.openCarDetailView(with: car)
    }
}

// MARK: - ICarsInteractorOutput

extension CarsPresenter: ICarsInteractorOutput {
    func rowAdded() {
        
    }
    
    func rowEdited(at index: Int) {
        
    }
    
    func rowDeleted(at index: Int) {
        
    }
    
    func dataFiltered() {
        
    }
}
