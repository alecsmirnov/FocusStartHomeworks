//
//  CarDetailViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol ICarDetailViewController: AnyObject {}

final class CarDetailViewController: UIViewController, ICarDetailViewController {
    // MARK: Properties
    
    var presenter: ICarDetailPresenter?
    
    private var carDetailView: CarDetailView {
        guard let view = view as? CarDetailView else {
            fatalError("view is not a CarDetailView instance")
        }
        
        return view
    }
    
    private var isLoaded = false
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = CarDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad(view: carDetailView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupButtons()
    }
}

// MARK: - Private Methods

private extension CarDetailViewController {
    private func showAlertMessage() {
        let title = "Required fields are empty!"
        let message = "Please fill in the fields:\nManufacturer, Model, Body"
        
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

       self.present(alert, animated: true)
   }
}

// MARK: - Buttons

private extension CarDetailViewController {
    func setupButtons() {
        if !isLoaded {
            carDetailView.getCarToEdit() != nil ? setupEditButtons() : setupAddButton()
            
            isLoaded = true
        }
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
    @objc func didPressAddButton() {
        if let car = carDetailView.getCarToEdit() {
            presenter?.didPressAddButton(with: car)
        } else {
            showAlertMessage()
        }
    }
    
    @objc func didPressEditButton() {
        if let car = carDetailView.getCarToEdit() {
            presenter?.didPressEditButton(with: car)
        } else {
            showAlertMessage()
        }
    }
    
    @objc func didPressDeleteButton() {
        presenter?.didPressDeleteButton()
    }
}

// MARK: - BodyPickerViewControllerDelegate

extension CarDetailViewController: BodyPickerViewControllerDelegate {
    func bodyPickerViewControllerDelegate(_ anyObject: AnyObject, didSelect body: Body?) {
        carDetailView.setBody(body)
    }
}
