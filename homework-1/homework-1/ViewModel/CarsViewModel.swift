//
//  CarsViewModel.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

class CarsViewModel {
    weak var delegate: CarsViewModelDisplayDelegate?
    
    var rowsCount: Int {
        return carService.count
    }
    
    var selectedRow: Int?
    
    private let carService: CarService
    
    init(carService: CarService) {
        self.carService = carService
    }
    
    func filterReset() {
        carService.filterReset()
    }
    
    func filter(by body: Body) {
        carService.filter(by: body)
    }
    
    func carCellViewModel(at index: Int) -> CarCellViewModel {
        return CarCellViewModel(car: carService.get(at: index))
    }
    
    func carDetailViewModel() -> CarDetailViewModel? {
        if let selectedRow = selectedRow {
            return CarDetailViewModel(car: carService.get(at: selectedRow), delegate: self)
        }
        else {
            return CarDetailViewModel(delegate: self)
        }
    }
}

// MARK: - CarDetailViewModelDelegate

extension CarsViewModel: CarDetailViewModelDelegate {
    func carDetailViewModelDelegate(_ viewModel: CarDetailViewModel, addCar car: Car) {
        carService.append(car: car)
        
        if let delegate = delegate {
            delegate.carsViewModelDisplayDelegate(self, addCar: car)
        }
        
        selectedRow = nil
    }
    
    func carDetailViewModelDelegate(_ viewModel: CarDetailViewModel, changeCar car: Car) {
        guard let selectedRow = selectedRow else { return }
        
        carService.replace(at: selectedRow, with: car)
        
        if let delegate = delegate {
            delegate.carsViewModelDisplayDelegate(self, reloadRowAt: selectedRow)
        }
        
        self.selectedRow = nil
    }
    
    func carDetailViewModelDelegateDeleteCar(_ viewModel: CarDetailViewModel) {
        guard let selectedRow = selectedRow else { return }
        
        carService.remove(at: selectedRow)
        
        if let delegate = delegate {
            delegate.carsViewModelDisplayDelegate(self, deleteRowAt: selectedRow)
        }
        
        self.selectedRow = nil
    }
}
