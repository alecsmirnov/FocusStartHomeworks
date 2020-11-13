//
//  BodyPickerViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

class BodyPickerViewController: UIViewController, BodyPickerViewControllerProtocol {
    // MARK: Properties
    
    weak var presenter: BodyPickerPresenterProtocol?
    
    var selectedBody: Body? {
        get { getSelectedBody() }
        set { setSelectedBody(newValue) }
    }
    
    var didSelectBody: BodySelectAction?
    
    private var bodyPickerView: BodyPickerViewProtocol {
        guard let view = view as? BodyPickerView else {
            fatalError("view is not a BodyPickerView instance")
        }
        
        return view
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = BodyPickerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBodySelectionAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupResetButton()
    }
}

// MARK: - Private Methods

private extension BodyPickerViewController {
    func getSelectedBody() -> Body? {
        return bodyPickerView.selectedBody
    }
    
    func setSelectedBody(_ body: Body?) {
        bodyPickerView.selectedBody = body
    }
}

// MARK: - Buttons

private extension BodyPickerViewController {
    func setupResetButton() {
        if presentingViewController != nil {
            let resetBarButtonItem = UIBarButtonItem(
                title: "Reset",
                style: .plain,
                target: self,
                action: #selector(didPressResetButton)
            )

            navigationItem.leftBarButtonItem = resetBarButtonItem
        }
    }
}

// MARK: - Actions

private extension BodyPickerViewController {
    func setupBodySelectionAction() {
        bodyPickerView.didSelectBody = { [weak self] body in
            self?.presenter?.didPressCloseButton()
            
            self?.didSelectBody?(body)
        }
    }
    
    @objc func didPressResetButton() {
        presenter?.didPressCloseButton()
        
        didSelectBody?(nil)
    }
}
