//
//  CarDetailViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol CarDetailViewControllerProtocol: AnyObject {
    var presenter: CarDetailPresenterProtocol? { get set }
    
    var carToEdit: Car? { get set }
    var bodyToReceive: Body? { get set }
    
    var delegate: CarDetailViewControllerProtocolDelegate? { get set }
}

final class CarDetailViewController: UIViewController, CarDetailViewControllerProtocol {
    // MARK: Properties
    
    weak var presenter: CarDetailPresenterProtocol?
    
    var carToEdit: Car? {
        get { carDetailView.carToEdit }
        set { carDetailView.carToEdit = newValue }
    }
    
    var bodyToReceive: Body? {
        get { carDetailView.bodyToReceive }
        set { carDetailView.bodyToReceive = newValue }
    }
    
    weak var delegate: CarDetailViewControllerProtocolDelegate?
    
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

// MARK: - Buttons

private extension CarDetailViewController {
    func setupButtons() {
        carToEdit != nil ? setupEditButtons() : setupAddButton()
    }
    
    func setupEditButtons() {
        let editBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: nil)
        let deleteBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [deleteBarButtonItem, editBarButtonItem]
    }
    
    func setupAddButton() {
        let addBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

// MARK: - Actions

private extension CarDetailViewController {
    func setupBodySelectionAction() {
        carDetailView.didSelectBody = { [weak self] body in
            self?.presenter?.didPressBodyButton(with: body)
            
            if let self = self,
               let body = body {
                self.delegate?.carDetailViewControllerProtocolDelegate(self, didSelect: body)
            }
        }
    }
}
