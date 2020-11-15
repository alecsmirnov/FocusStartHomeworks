//
//  BodyPickerViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol IBodyPickerViewController: AnyObject {}

final class BodyPickerViewController: UIViewController, IBodyPickerViewController  {
    // MARK: Properties
    
    var presenter: IBodyPickerPresenter?
    
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
        
        presenter?.viewDidLoad(view: bodyPickerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupResetButton()
    }
}

// MARK: - Button

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
    
    @objc func didPressResetButton() {
        presenter?.didPressResetButton()
    }
}
