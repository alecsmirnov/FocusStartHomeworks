//
//  CarsViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol ICarsViewController: AnyObject {
    func setFilter(with body: Body?)
    
    //func updateCarsView()
}

final class CarsViewController: UIViewController {
    // MARK: Properties
    
    var presenter: ICarsPresenter?
    
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
    func reloadData() {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.carsView.reloadData()
        }, completion: nil)
    }
}

// MARK: - ICarsViewController Protocol

extension CarsViewController: ICarsViewController {
    func setFilter(with body: Body?) {
        presenter?.filter = body
        
        setFilterStatus(body: body)
        
        reloadData()
    }
}

// MARK: - CarsView

private extension CarsViewController {
    func setupCarsView() {
        carsView.tableViewDataSource = self
        carsView.tableViewDelegate = self
    }

    func updateCarsView() {
        switch carsViewUpdateType {
        case .insertNewRow: carsView.insertNewRow()
        case .updateRow(let index): carsView.reloadRow(at: index)
        case .deleteRow(let index): carsView.deleteRow(at: index)
        case .none: break
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
    func carsViewControllerDelegate(_ anyObject: AnyObject, addNew car: Car) {
        presenter?.append(car: car)
        
        carsViewUpdateType = .insertNewRow
    }
    
    func carsViewControllerDelegate(_ anyObject: AnyObject, edit car: Car) {
        if let index = selectedIndexRow {
            presenter?.replace(at: index, with: car)
            
            carsViewUpdateType = .updateRow(index: index)
        }
    }
    
    func carsViewControllerDelegateDeleteCar(_ anyObject: AnyObject) {
        if let index = selectedIndexRow {
            presenter?.remove(at: index)
            
            carsViewUpdateType = .deleteRow(index: index)
        }
    }
}

// MARK: - BodyPickerViewControllerDelegate

extension CarsViewController: BodyPickerViewControllerDelegate {
    func bodyPickerViewControllerDelegate(_ anyObject: AnyObject, didSelect body: Body?) {
        presenter?.filter = body
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
