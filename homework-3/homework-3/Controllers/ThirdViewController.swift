//
//  ThirdViewController.swift
//  homework-3
//
//  Created by Admin on 29.10.2020.
//

import UIKit

class ThirdViewController: UIViewController {
    // MARK: Properties
    
    private var thirdView: ThirdView {
        guard let thirdView = view as? ThirdView else {
            fatalError("view is not a ThirdView instance")
        }
        
        return thirdView
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        view = ThirdView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonActions()
    }
}

// MARK: - Actions

private extension ThirdViewController {
    func configureButtonActions() {
        thirdView.enterButtonAction = { [weak self] login, password in
            guard let _ = self else { return }
            
            print("enter pressed")
            print("login: \(login ?? "")")
            print("password: \(password ?? "")")
        }
    }
}
