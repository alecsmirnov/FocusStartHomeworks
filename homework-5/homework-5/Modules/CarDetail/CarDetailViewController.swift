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
    
    private var isLoaded = false
    
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
    func getUserInput() -> Car? {
        return carDetailView.carToEdit
    }
}

// MARK: - Buttons

private extension CarDetailViewController {
    func setupButtons() {
        if !isLoaded {
            carToEdit != nil ? setupEditButtons() : setupAddButton()
            
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
    func setupBodySelectionAction() {
        carDetailView.didSelectBody = { [weak self] body in
            self?.presenter?.didPressBodyButton(with: body)
        }
    }
    
    @objc func didPressAddButton() {
        guard let car = getUserInput() else { return }
    
        delegate?.carsViewControllerDelegate(self, addNew: car)
        
        presenter?.didPressCloseButton()
    }
    
    @objc func didPressEditButton() {
        guard let car = getUserInput() else { return }
        
        delegate?.carsViewControllerDelegate(self, edit: car)
        
        presenter?.didPressCloseButton()
    }
    
    @objc func didPressDeleteButton() {
        delegate?.carsViewControllerDelegateDeleteCar(self)
        
        presenter?.didPressCloseButton()
    }
}
