//
//  CarsViewController.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import UIKit

class CarsViewController: UIViewController {
    var carsViewModel: CarsViewModel?
    
    private enum CarsTableViewUpdateType {
        case insertNewRow
        case updateRow(index: Int)
        case deleteRow(index: Int)
        case none
    }
    
    private enum CarsTableView {
        static let carCell = "CarCell"
    }
    
    private enum Segue {
        static let addCar = "AddCar"
        static let editCar = "EditCar"
    }
    
    private var carsTableViewUpdateType = CarsTableViewUpdateType.none
    
    @IBOutlet private weak var dropDownView: DropDownView!
    @IBOutlet private weak var carsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsTableView.tableFooterView = UIView()
        
        dropDownView.delegate = self
        
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
        if let carsViewModel = carsViewModel {
            carsViewModel.delegate = self
        }
        
        let dropDownData = ["All"] + Body.allCases.map { $0.description }
        dropDownView.configure(data: dropDownData, fieldData: "All")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateTable()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let carDetailViewController = segue.destination as? CarDetailViewController else { return }
        
        switch segue.identifier {
        case Segue.addCar: carDetailViewController.carDetailMode = .add
        case Segue.editCar: carDetailViewController.carDetailMode = .edit
        default: break
        }
        
        if let carsViewModel = carsViewModel {
            carDetailViewController.carDetailViewModel = carsViewModel.carDetailViewModel()
        }
    }
    
    // MARK: - Private Methods
    
    private func updateTable() {
        switch carsTableViewUpdateType {
        case .insertNewRow:
            let newRowIndex = carsTableView.numberOfRows(inSection: 0)
            let rowIndexPath = IndexPath(row: newRowIndex, section: 0)
            
            carsTableView.insertRows(at: [rowIndexPath], with: .automatic)
        case .updateRow(let index):
            let rowIndexPath = IndexPath(row: index, section: 0)

            carsTableView.reloadRows(at: [rowIndexPath], with: .automatic)
        case .deleteRow(let index):
            let rowIndexPath = IndexPath(row: index, section: 0)
            
            carsTableView.deleteRows(at: [rowIndexPath], with: .automatic)
        case .none:
            break
        }
        
        carsTableViewUpdateType = .none
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            if let carsViewModel = self.carsViewModel {
                carsViewModel.remove(at: indexPath.row)
                self.carsTableView.deleteRows(at: [indexPath], with: .automatic)
                
                completionHandler(true)
            }
        }
        
        delete.image = UIImage.init(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - CarsViewModelDisplayDelegate

extension CarsViewController: CarsViewModelDisplayDelegate {
    func carsViewModelDisplayDelegateInsertNewRow(_ viewModel: CarsViewModel) {
        carsTableViewUpdateType = .insertNewRow
    }
    
    func carsViewModelDisplayDelegate(_ viewModel: CarsViewModel, reloadRowAt index: Int) {
        carsTableViewUpdateType = .updateRow(index: index)
    }
    
    func carsViewModelDisplayDelegate(_ viewModel: CarsViewModel, deleteRowAt index: Int) {
        carsTableViewUpdateType = .deleteRow(index: index)
    }
}

// MARK: - DropDownViewDelegate

extension CarsViewController: DropDownViewDelegate {
    func dropDownViewDelegate(_ view: DropDownView, itemPressedAt row: Int) {
        if let carsViewModel = carsViewModel {
            if row == 0 {
                carsViewModel.filterReset()
            } else if let body = Body(rawValue: row - 1) {
                carsViewModel.filter(by: body)
            }
        }
    
        UIView.transition(with: carsTableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.carsTableView.reloadData()
        }, completion: nil)
    }
}
