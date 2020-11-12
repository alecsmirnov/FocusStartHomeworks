//
//  BodyPickerViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

class BodyPickerViewController: UIViewController {
    // MARK: Delegate
    
    weak var delegate: BodySelectionDelegate?
    
    // MARK: Properties
    
    var bodyToSelect: Body?  {
        get { bodyPickerView.bodyToSelect }
        set { bodyPickerView.bodyToSelect = newValue }
    }
    
    private var bodyPickerView: BodyPickerView {
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
        
        setupViewBodySelectAction()
    }
}

// MARK: - Actions

private extension BodyPickerViewController{
    func setupViewBodySelectAction() {
        bodyPickerView.didSelectBody = { [weak self] body in
            guard let self = self else { return }
            self.delegate?.bodySelectionDelegate(self, didSelect: body)
        }
    }
}
