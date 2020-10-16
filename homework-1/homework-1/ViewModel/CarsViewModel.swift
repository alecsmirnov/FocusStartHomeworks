//
//  CarsViewModel.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import Foundation

class CarsViewModel {
    //weak var delegate: CarsViewModelDisplayDelegate?
    
    var rowsCount: Int {
        return carService.count
    }
    
    private let carService: CarService
    
    init(carService: CarService) {
        self.carService = carService
    }
    
    func editViewModel(at index: Int) -> EditViewModel {
        return EditViewModel()
    }
    
    func carCellViewModel(at index: Int) -> CarCellViewModel {
        return CarCellViewModel(car: carService.get(at: index))
    }
}

//
//// MARK: - EditorViewModelDelegate
//extension CarsViewModel: EditorViewModelDelegate {
//    func editorViewModelDelegateAddCar(_ viewModel: AnyObject, car: Car) {
//        carsModel.append(car: car)
//
//        if let delegate = delegate {
//            delegate.carsViewModelDisplayDelegateReloadData(self)
//        }
//    }
//
//    func editorViewModelDelegateEditCar(_ viewModel: AnyObject, car: Car, at index: Int) {
//        carsModel.replace(at: index, with: car)
//
//        if let delegate = delegate {
//            delegate.carsViewModelDisplayDelegateReloadRow(self, at: index)
//        }
//    }
//
//    func editorViewModelDelegateDeleteCar(_ viewModel: AnyObject, at index: Int) {
//        carsModel.remove(at: index)
//
//        if let delegate = delegate {
//            delegate.carsViewModelDisplayDelegateReloadData(self)
//        }
//    }
//}
