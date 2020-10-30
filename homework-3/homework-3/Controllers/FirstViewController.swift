//
//  FirstViewController.swift
//  homework-3
//
//  Created by Admin on 29.10.2020.
//

import UIKit

class FirstViewController: UIViewController {
    private var firstView: FirstView {
        guard let firstView = view as? FirstView else {
            fatalError("view is not a FirstView instance")
        }
        
        return firstView
    }
    
    override func loadView() {
        super.loadView()
        
        view = FirstView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView.roundButtonAction = { [weak self] in
            guard let _ = self else { return }
            
            print("round pressed")
        }
        
        firstView.ovalButtonAction = { [weak self] in
            guard let _ = self else { return }
            
            print("oval pressed")
        }
    }
}
