//
//  DetailViewController.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: Properties
    
    private var detailView: DetailView {
        guard let detailView = view as? DetailView else {
            fatalError("view is not a DetailView instance")
        }
        
        return detailView
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = DetailView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
