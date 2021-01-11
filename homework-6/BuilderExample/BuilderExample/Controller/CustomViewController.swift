//
//  CustomViewController.swift
//  BuilderExample
//
//  Created by Admin on 18.11.2020.
//

import UIKit

class CustomViewController: UIViewController {    
    // MARK: Lifecycle
    
    override func loadView() {
        let customViewBuilder = CustomViewBuilder()
        let customViewDirector = CustomViewDirector(customViewBuilder: customViewBuilder)
        customViewDirector.createCustomViewExample(with: #selector(didPressRoundButton))
        
        view = customViewBuilder.build()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Actions

private extension CustomViewController {
    @objc func didPressRoundButton() {
        print("Round button pressed")
    }
}
