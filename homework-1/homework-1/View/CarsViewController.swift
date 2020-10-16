//
//  CarsViewController.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import UIKit

class CarsViewController: UIViewController {
    enum CarsTableView {
        static let carCell = "CarCell"
    }
    
    enum Segue {
        static let addCar  = "AddCar"
        static let editCar = "EditCar"
    }
    
    var carsViewModel: CarsViewModel?
    
    private var dispatchWorkItem: DispatchWorkItem?
    
    @IBOutlet private weak var dropDownView: DropDownView!
    @IBOutlet private weak var carsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var data: [String] = []
        
        for body in Body.allCases {
            data.append(body.rawValue)
        }
        
        dropDownView.delegate = self
        
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
        if let carsViewModel = carsViewModel {
            carsViewModel.delegate = self
        }
        
        dropDownView.configure(data: data, fieldData: "Choose a body type")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let dispatchWorkItem = dispatchWorkItem {
            DispatchQueue.global(qos: .userInteractive).async(execute: dispatchWorkItem)
        }
        
        dispatchWorkItem = nil
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let carDetailViewController = segue.destination as? CarDetailViewController else { return }
        
        switch segue.identifier {
        case Segue.addCar:
            carDetailViewController.carDetailMode = .add
            break
        case Segue.editCar:
            carDetailViewController.carDetailMode = .edit
        default:
            break
        }
        
        if let carsViewModel = carsViewModel,
           let carDetailViewModel = carsViewModel.carDetailViewModel() {
            carDetailViewController.carDetailViewModel = carDetailViewModel
        }
    }
}

// MARK: - UITableViewDataSource

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsCount = 0
        
        if let carsViewModel = carsViewModel {
            rowsCount = carsViewModel.rowsCount
        }
        
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carCell = carsTableView.dequeueReusableCell(withIdentifier: CarsTableView.carCell) as! CarCell
        
        if let carsViewModel = carsViewModel {
            carCell.carCellViewModel = carsViewModel.carCellViewModel(at: indexPath.row)
        }
        
        return carCell
    }
}

// MARK: - UITableViewDelegate

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let carsViewModel = carsViewModel {
            carsViewModel.selectedRow = indexPath.row
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        carsTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CarsViewModelDisplayDelegate

extension CarsViewController: CarsViewModelDisplayDelegate {
    func carsViewModelDisplayDelegate(_ viewModel: CarsViewModel, addCar: Car) {
        let newRowIndex = carsTableView.numberOfRows(inSection: 0)
        let rowIndexPath = IndexPath(row: newRowIndex, section: 0)
        
        dispatchWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.carsTableView.insertRows(at: [rowIndexPath], with: .automatic)
            }
        }
    }
    
    func carsViewModelDisplayDelegate(_ viewModel: CarsViewModel, reloadRowAt index: Int) {
        let rowIndexPath = IndexPath(row: index, section: 0)
        
        dispatchWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.carsTableView.reloadRows(at: [rowIndexPath], with: .automatic)
            }
        }
    }
    
    func carsViewModelDisplayDelegate(_ viewModel: CarsViewModel, deleteRowAt index: Int) {
        let rowIndexPath = IndexPath(row: index, section: 0)
        
        dispatchWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.carsTableView.deleteRows(at: [rowIndexPath], with: .automatic)
            }
        }
    }
}

// MARK: - DropDownViewDelegate

extension CarsViewController: DropDownViewDelegate {
    func dropDownViewDelegate(_ view: DropDownView, itemPressedAt row: Int) {
        print("\(row)")
    }
}
