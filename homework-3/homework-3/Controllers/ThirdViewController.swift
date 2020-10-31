//
//  ThirdViewController.swift
//  homework-3
//
//  Created by Admin on 29.10.2020.
//

import UIKit

class ThirdViewController: UIViewController {
    private var thirdView: ThirdView {
        guard let thirdView = view as? ThirdView else {
            fatalError("view is not a ThirdView instance")
        }
        
        return thirdView
    }
    
    override func loadView() {
        view = ThirdView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thirdView.enterButtonAction = { [weak self] in
            guard let _ = self else { return }
            
            print("enter pressed")
        }
    }
}
