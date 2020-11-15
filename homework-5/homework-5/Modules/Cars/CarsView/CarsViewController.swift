//
//  CarsViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

final class CarsViewController: UIViewController, CarsViewProtocol {
    // MARK: Properties
    
    var presenter: CarsPresenterProtocol?
    
    private enum FilterSettings {
        static let title = "Filter"
        static let defaultStatus = "All"
    }
    
    private enum CarsViewUpdateType {
        case insertNewRow
        case updateRow(index: Int)
        case deleteRow(index: Int)
        case none
    }
    
    private var carsView: CarsView {
        guard let view = view as? CarsView else {
            fatalError("view is not a CarsView instance")
        }
        
        return view
    }
    
    private var selectedIndexRow: Int?
    private var carsViewUpdateType = CarsViewUpdateType.none
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = CarsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCarsView()
        setupButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateCarsView()
    }
}

// MARK: - Public Methods

extension CarsViewController {
    func setFilter(with body: Body?) {
        presenter?.setFilter(by: body)
        
        setFilterStatus(body: body)
        
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.carsView.reloadData()
        }, completion: nil)
    }
}

// MARK: - CarsView

private extension CarsViewController {
    func setupCarsView() {
        carsView.dataSource = self
        carsView.delegate = self
        
        registerCells()
    }
    
    func registerCells() {
        carsView.register(CarCell.self, forCellReuseIdentifier: CarCell.reuseIdentifier)
    }
    
    func updateCarsView() {
        switch carsViewUpdateType {
        case .insertNewRow:
            let rowsCount = presenter?.count ?? 0
            let newRowIndex = rowsCount - 1
            let rowIndexPath = IndexPath(row: newRowIndex, section: 0)
            carsView.insertRows(at: [rowIndexPath], with: .automatic)
        case .updateRow(let index):
            let rowIndexPath = IndexPath(row: index, section: 0)

            carsView.reloadRows(at: [rowIndexPath], with: .automatic)
        case .deleteRow(let index):
            let rowIndexPath = IndexPath(row: index, section: 0)
            
            carsView.deleteRows(at: [rowIndexPath], with: .automatic)
        case .none:
            break
        }
        
        carsViewUpdateType = .none
    }
}

// MARK: - Buttons

private extension CarsViewController {
    func setupButtons() {
        setupFilterButton()
        setupAddButton()
    }
    
    func setupFilterButton() {
        let filterBarButtonItem = UIBarButtonItem(
            title: FilterSettings.title,
            style: .plain,
            target: self,
            action: #selector(didPressFilterButton)
        )
        
        let filterStatusBarButtonItem = UIBarButtonItem(
            title: FilterSettings.defaultStatus,
            style: .plain,
            target: self,
            action: nil
        )
        filterStatusBarButtonItem.isEnabled = false
        
        navigationItem.leftBarButtonItems = [filterBarButtonItem, filterStatusBarButtonItem]
    }
    
    func setupAddButton() {
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressAddButton)
        )
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    func setFilterStatus(body: Body?) {
        if let filterStatusBarButtonItem = navigationItem.leftBarButtonItems?.last {
            filterStatusBarButtonItem.title = body?.rawValue ?? FilterSettings.defaultStatus
        }
    }
    
    func getFilterStatus() -> Body? {
        guard let filterStatusBarButtonItem = navigationItem.leftBarButtonItems?.last else { return nil }
        
        return Body(rawValue: filterStatusBarButtonItem.title ?? "")
    }
}

// MARK: - Actions

extension CarsViewController {
    @objc func didPressFilterButton() {
        presenter?.didPressFilterButton(with: getFilterStatus())
    }
    
    @objc func didPressAddButton() {
        presenter?.didPressAddButton()
    }
}

// MARK: - CarDetailViewControllerDelegate

extension CarsViewController: CarDetailViewControllerDelegate {
    func carsViewControllerDelegate(_ viewController: CarDetailViewController, addNew car: Car) {
        presenter?.append(car: car)
        
        carsViewUpdateType = .insertNewRow
    }
    
    func carsViewControllerDelegate(_ viewController: CarDetailViewController, edit car: Car) {
        if let index = selectedIndexRow {
            presenter?.replace(at: index, with: car)
            
            carsViewUpdateType = .updateRow(index: index)
        }
    }
    
    func carsViewControllerDelegateDeleteCar(_ viewController: CarDetailViewController) {
        if let index = selectedIndexRow {
            presenter?.remove(at: index)
            
            carsViewUpdateType = .deleteRow(index: index)
        }
    }
}

// MARK: - UITableViewDataSource

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CarCell.reuseIdentifier,
            for: indexPath
        ) as? CarCell else { return UITableViewCell() }

        if let car = presenter?.get(at: indexPath.row) {
            cell.configure(with: car)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexRow = indexPath.row
        
        if let car = presenter?.get(at: indexPath.row) {
            presenter?.didSelectRow(with: car)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            self?.presenter?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
                
            completionHandler(true)
        }
        
        delete.image = UIImage.init(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
