//
//  EmployeesViewController.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

import UIKit

protocol IEmployeesViewController: AnyObject {
    func updateAddingData()
    func updateDeletedData(at index: Int)
    
    func reloadData(at index: Int)
}

final class EmployeesViewController: UIViewController {
    // MARK: Properties
    
    var presenter: IEmployeesPresenter?
    
    private var employeesView: EmployeesView {
        guard let view = view as? EmployeesView else {
            fatalError("view is not a EmployeesView instance")
        }
        
        return view
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = EmployeesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmployeesView()
        setupButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear()
    }
}

// MARK: - IEmployeesViewController

extension EmployeesViewController: IEmployeesViewController {
    func updateAddingData() {
        employeesView.insertNewRow()
    }
    
    func updateDeletedData(at index: Int) {
        employeesView.deleteRow(at: index)
    }
    
    func reloadData(at index: Int) {
        employeesView.reloadRow(at: index)
    }
}

// MARK: - Private Methods

private extension EmployeesViewController {
    func setupEmployeesView() {
        employeesView.tableViewDataSource = self
        employeesView.tableViewDelegate = self
    }
    
    func reloadData() {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.employeesView.reloadData()
        }, completion: nil)
    }
}

// MARK: - Buttons

private extension EmployeesViewController {
    func setupButtons() {
        setupAddButton()
    }
    
    func setupAddButton() {
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressAddButton)
        )
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

// MARK: - Actions

extension EmployeesViewController {
    @objc func didPressAddButton() {
        presenter?.didPressAddButton()
    }
}

// MARK: - UITableViewDataSource

extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EmployeeCell.reuseIdentifier,
            for: indexPath
        ) as? EmployeeCell else { return UITableViewCell() }

        if let employee = presenter?.get(at: indexPath.row) {
            cell.configure(with: employee)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension EmployeesViewController: UITableViewDelegate {
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

//// MARK: - CarDetailViewControllerDelegate
//
//extension EmployeesViewController: CarDetailViewControllerDelegate {
//    func carsViewControllerDelegate(_ anyObject: AnyObject, addNew car: Car) {
//        presenter?.addNewCar(car)
//    }
//
//    func carsViewControllerDelegate(_ anyObject: AnyObject, edit car: Car) {
//        presenter?.editCar(car)
//    }
//
//    func carsViewControllerDelegateDeleteCar(_ anyObject: AnyObject) {
//        presenter?.deleteCar()
//    }
//}
