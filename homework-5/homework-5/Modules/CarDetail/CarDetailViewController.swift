//
//  CarDetailViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol CarDetailViewControllerProtocol: AnyObject {
    var carToEdit: Car? { get set }
}

final class CarDetailViewController: UIViewController {
    weak var presenter: CarDetailPresenterProtocol?
    
    // MARK: Properties
    
    var bodyToReceive: Body? {
        get { carDetailView.bodyToReceive }
        set { carDetailView.bodyToReceive = newValue }
    }
    
    private var carDetailView: CarDetailView {
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
        
        setupViewBodySelectAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if carToEdit != nil {
            setupEditButtons()
        } else {
            setupAddButton()
        }
    }
}

extension CarDetailViewController: CarDetailViewControllerProtocol {
    var carToEdit: Car? {
        get { carDetailView.carToEdit }
        set { carDetailView.carToEdit = newValue }
    }
}

// MARK: - Actions

private extension CarDetailViewController {
    func setupViewBodySelectAction() {
        carDetailView.didSelectBody = { [weak self] body in
            guard let self = self else { return }
            
            //self.delegate?.bodySelectionDelegate(self, didSelect: body)
        }
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
