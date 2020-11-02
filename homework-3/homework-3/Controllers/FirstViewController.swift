//
//  FirstViewController.swift
//  homework-3
//
//  Created by Admin on 29.10.2020.
//

import UIKit

class FirstViewController: UIViewController {
    // MARK: Properties
    
    private var firstView: FirstView {
        guard let firstView = view as? FirstView else {
            fatalError("view is not a FirstView instance")
        }
        
        return firstView
    }
    
    // MARK: Life Cycle
    
    override func loadView() {        
        view = FirstView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonsActions()
    }
}

// MARK: - Actions

private extension FirstViewController {
    func configureButtonsActions() {
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
