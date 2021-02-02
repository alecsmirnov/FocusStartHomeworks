//
//  CarsPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

protocol ICarsPresenter: AnyObject {
    var count: Int { get }
    
    func viewDidAppear(view: ICarsView)
    
    func get(at index: Int) -> Car?
    func remove(at index: Int)
    func addNewCar(_ car: Car)
    func editCar(_ car: Car)
    func deleteCar()
    
    func setFilter(with body: Body?)
    
    func didPressFilterButton(with body: Body?)
    func didPressAddButton()
    func didSelectRow(at index: Int)
}

final class CarsPresenter {
    weak var view: ICarsViewController?
    var interactor: ICarsInteractor?
    var router: ICarsRouter?
    
    private enum CarsViewUpdateType {
        case insertNewRow
        case updateRow(index: Int)
        case deleteRow(index: Int)
        case none
    }
    
    private var carsViewUpdateType = CarsViewUpdateType.none
    
    private var selectedRowIndex: Int?
}

// MARK: - ICarsPresenter

extension CarsPresenter: ICarsPresenter {
    // MARK: Properties
    
    var count: Int {
        return interactor?.count ?? 0
    }

    // MARK: Lifecycle
    
    func viewDidAppear(view: ICarsView) {
        switch carsViewUpdateType {
        case .insertNewRow: view.insertNewRow()
        case .updateRow(let index): view.reloadRow(at: index)
        case .deleteRow(let index): view.deleteRow(at: index)
        case .none: break
        }
        
        carsViewUpdateType = .none
    }
    
    // MARK: Input

    func get(at index: Int) -> Car? {
        return interactor?.get(at: index)
    }
    
    func remove(at index: Int) {
        interactor?.remove(at: index)
    }
    
    func addNewCar(_ car: Car) {
        interactor?.append(car: car)
        
        carsViewUpdateType = .insertNewRow
    }
    
    func editCar(_ car: Car) {
        if let index = selectedRowIndex {
            interactor?.replace(at: index, with: car)
            
            carsViewUpdateType = .updateRow(index: index)
        }
    }
    
    func deleteCar() {
        if let index = selectedRowIndex {
            interactor?.remove(at: index)
            
            carsViewUpdateType = .deleteRow(index: index)
        }
    }
    
    func setFilter(with body: Body?) {
        interactor?.setFilter(with: body)
    }

    // MARK: Actions
    
    func didPressFilterButton(with body: Body?) {
        router?.openFilterView(with: body)
    }
    
    func didPressAddButton() {
        router?.openCarDetailView()
    }
    
    func didSelectRow(at index: Int) {
        selectedRowIndex = index
        
        if let car = interactor?.get(at: index) {
            router?.openCarDetailView(with: car)
        }
    }
}

// MARK: - ICarsInteractorOutput

extension CarsPresenter: ICarsInteractorOutput {    
    func dataFiltered() {
        view?.applyFilter(with: interactor?.getFilter())
    }
}
