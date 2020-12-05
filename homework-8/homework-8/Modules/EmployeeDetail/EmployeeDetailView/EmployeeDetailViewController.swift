//
//  EmployeeDetailViewController.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

import UIKit

protocol IEmployeeDetailViewController: AnyObject {
    func setEmployee(_ employee: Employee)
    
    func setupAddAppearance()
    func setupEditAppearance()
    
    func showAlertMessage()
}

final class EmployeeDetailViewController: UIViewController {
    // MARK: Properties
    
    var presenter: IEmployeeDetailPresenter?
    
    private var employeeDetailView: EmployeeDetailView {
        guard let view = view as? EmployeeDetailView else {
            fatalError("view is not a EmployeeDetailView instance")
        }
        
        return view
    }
    
    private var isLoaded = false
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = EmployeeDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
}

// MARK: - IEmployeeDetailViewController

extension EmployeeDetailViewController: IEmployeeDetailViewController {
    func setEmployee(_ employee: Employee) {
        employeeDetailView.setEmployee(employee)
    }
    
    func setupAddAppearance() {
        navigationItem.title = "New Employee"
        
        setupAddButton()
    }
    
    func setupEditAppearance() {
        navigationItem.title = "Edit Employee"
        
        setupEditButtons()
    }
    
    func showAlertMessage() {
        let title = "Required fields are empty!"
        let message = "Please fill in the fields:\nName, Age, Post."
        
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

       self.present(alert, animated: true)
    }
}

// MARK: - Buttons

private extension EmployeeDetailViewController {
    func setupAddButton() {
        let addBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(didPressAddButton)
        )
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    func setupEditButtons() {
        let editBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(didPressEditButton)
        )
        
        let deleteBarButtonItem = UIBarButtonItem(
            title: "Delete",
            style: .plain,
            target: self,
            action: #selector(didPressDeleteButton)
        )
        
        navigationItem.rightBarButtonItems = [deleteBarButtonItem, editBarButtonItem]
    }
}

// MARK: - Actions

private extension EmployeeDetailViewController {
    @objc func didPressAddButton() {
        presenter?.didPressAddButton(with: employeeDetailView.getEmployee())
    }

    @objc func didPressEditButton() {
        presenter?.didPressEditButton(with: employeeDetailView.getEmployee())
    }

    @objc func didPressDeleteButton() {
        presenter?.didPressDeleteButton()
    }
}
