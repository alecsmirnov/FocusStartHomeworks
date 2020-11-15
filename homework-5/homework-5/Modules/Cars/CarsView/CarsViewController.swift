//
//  CarsViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol ICarsViewController: AnyObject {
    func applyFilter(with body: Body?)
}

final class CarsViewController: UIViewController {
    // MARK: Properties
    
    var presenter: ICarsPresenter?
    
    private enum FilterSettings {
        static let title = "Filter"
        static let defaultStatus = "All"
    }
    
    private var carsView: CarsView {
        guard let view = view as? CarsView else {
            fatalError("view is not a CarsView instance")
        }
        
        return view
    }
    
    private var selectedIndexRow: Int?
    
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
        
        presenter?.viewDidAppear(view: carsView)
    }
}

// MARK: - ICarsViewController

extension CarsViewController: ICarsViewController {
    func applyFilter(with body: Body?) {
        setFilterStatus(body: body)
        
        reloadData()
    }
}

// MARK: - Private Methods

private extension CarsViewController {
    func setupCarsView() {
        carsView.tableViewDataSource = self
        carsView.tableViewDelegate = self
    }
    
    func reloadData() {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.carsView.reloadData()
        }, completion: nil)
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
        presenter?.didSelectRow(at: indexPath.row)
        
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

// MARK: - CarDetailViewControllerDelegate

extension CarsViewController: CarDetailViewControllerDelegate {
    func carsViewControllerDelegate(_ anyObject: AnyObject, addNew car: Car) {
        presenter?.addNewCar(car)
    }
    
    func carsViewControllerDelegate(_ anyObject: AnyObject, edit car: Car) {
        presenter?.editCar(car)
    }
    
    func carsViewControllerDelegateDeleteCar(_ anyObject: AnyObject) {
        presenter?.deleteCar()
    }
}

// MARK: - BodyPickerViewControllerDelegate

extension CarsViewController: BodyPickerViewControllerDelegate {
    func bodyPickerViewControllerDelegate(_ anyObject: AnyObject, didSelect body: Body?) {
        presenter?.setFilter(with: body)
    }
}
