//
//  CarDetailViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

final class CarDetailViewController: UIViewController, CarDetailViewControllerProtocol {
    // MARK: Properties
    
    weak var presenter: CarDetailPresenterProtocol?
    
    weak var delegate: CarDetailViewControllerDelegate?
    
    var carToEdit: Car? {
        get { carDetailView.carToEdit }
        set { carDetailView.carToEdit = newValue }
    }
    
    var bodyToReceive: Body? {
        get { carDetailView.bodyToReceive }
        set { carDetailView.bodyToReceive = newValue }
    }
    
    private var carDetailView: CarDetailViewProtocol {
        guard let view = view as? CarDetailView else {
            fatalError("view is not a CarDetailView instance")
        }
        
        return view
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = CarDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBodySelectionAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupButtons()
    }
}

// MARK: - Private Methods

private extension CarDetailViewController {
//    func getUserInput() -> Car? {
//        guard let manufacturer = manufacturerTextField.text,
//              let model = modelTextField.text,
//              let selectedRow = dropDownView.selectedRow,
//              let body = Body(rawValue: selectedRow) else {
//            let title = "Required fields are empty!"
//            let message = "Please fill in the fields:\nManufacturer, Model, Body Type"
//            showAlertMessage(title: title, message: message)
//            return nil
//        }
//
//        var yearOfIssue: Int?
//        if let yearOfIssueText = yearOfIssueTextField.text {
//            yearOfIssue = Int(yearOfIssueText)
//        }
//
//        let carNumber = carNumberTextField.text
//
//        let carInput = Car(manufacturer: manufacturer,
//                           model: model,
//                           body: body,
//                           yearOfIssue: yearOfIssue,
//                           carNumber: carNumber)
//
//        return carInput
//    }
}

// MARK: - Buttons

private extension CarDetailViewController {
    func setupButtons() {
        carToEdit != nil ? setupEditButtons() : setupAddButton()
    }
    
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

private extension CarDetailViewController {
    func setupBodySelectionAction() {
        carDetailView.didSelectBody = { [weak self] body in
            self?.presenter?.didPressBodyButton(with: body)
        }
    }
    
    @objc func didPressAddButton() {
        let car = Car(manufacturer: "man", model: "mod", body: .cabriolet, yearOfIssue: nil, carNumber: nil)
        
        delegate?.carsViewControllerDelegate(self, addNew: car)
        
        presenter?.didPressCloseButton()
    }
    
    @objc func didPressEditButton() {
        let car = Car(manufacturer: "man", model: "mod", body: .cabriolet, yearOfIssue: nil, carNumber: nil)
        
        delegate?.carsViewControllerDelegate(self, edit: car)
        
        presenter?.didPressCloseButton()
    }
    
    @objc func didPressDeleteButton() {
        delegate?.carsViewControllerDelegateDeleteCar(self)
        
        presenter?.didPressCloseButton()
    }
}
