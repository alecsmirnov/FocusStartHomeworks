//
//  SecondViewController.swift
//  homework-3
//
//  Created by Admin on 29.10.2020.
//

import UIKit

class SecondViewController: UIViewController {
    private var secondView: SecondView {
        guard let secondView = view as? SecondView else {
            fatalError("view is not a SecondView instance")
        }
        
        return secondView
    }
    
    override func loadView() {       
        view = SecondView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
