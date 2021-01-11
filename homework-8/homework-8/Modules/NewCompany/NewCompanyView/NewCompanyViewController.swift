//
//  NewCompanyViewController.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

import UIKit

protocol INewCompanyViewController: AnyObject {
    func showAlertMessage()
}

final class NewCompanyViewController: UIViewController {
    // MARK: Properties
    
    var presenter: INewCompanyPresenter?
    
    private var newCompanyView: NewCompanyView {
        guard let view = view as? NewCompanyView else {
            fatalError("view is not a NewCompanyView instance")
        }
        
        return view
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = NewCompanyView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
}

// MARK: - INewCompanyViewController

extension NewCompanyViewController: INewCompanyViewController {
    func showAlertMessage() {
        let title = "Required fields are empty!"
        let message = "Please fill in the fields:\nName"
        
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

       self.present(alert, animated: true)
   }
}

// MARK: - Private Methods

private extension NewCompanyViewController {
    func setupAppearance() {
        navigationItem.title = "New Company"
        
        setupAddButton()
    }
}

// MARK: - Buttons

private extension NewCompanyViewController {
    func setupAddButton() {
        let addBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(didPressAddButton)
        )
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

// MARK: - Actions

private extension NewCompanyViewController {
    @objc func didPressAddButton() {
        presenter?.didPressAddButton(with: newCompanyView.nameText)
    }
}
