//
//  BodyPickerViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol BodyPickerViewControllerProtocol: AnyObject {
    var presenter: BodyPickerPresenterProtocol? { get set }
    
    var selectedBody: Body? { get set }
}

class BodyPickerViewController: UIViewController, BodyPickerViewControllerProtocol {
    // MARK: Properties
    
    weak var presenter: BodyPickerPresenterProtocol?
    
    var selectedBody: Body? {
        get { bodyPickerView.selectedBody }
        set { bodyPickerView.selectedBody = newValue }
    }
    
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
}

// MARK: - Actions

private extension BodyPickerViewController {
    func setupBodySelectionAction() {
        bodyPickerView.didSelectBody = { [weak self] body in
            self?.presenter?.didSelectBody(body)
        }
    }
}
