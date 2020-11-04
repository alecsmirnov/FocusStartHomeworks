//
//  TableViewController.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

protocol TableViewControllerDelegate: AnyObject {
    func tableViewControllerDelegate(_ viewController: AnyObject, selectRowAt index: Int)
}

final class TableViewController: UIViewController {
    // MARK: Properties
    
    private var tableView: TableView {
        guard let tableView = view as? TableView else {
            fatalError("view is not a TableView instance")
        }
        
        return tableView
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = TableView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
