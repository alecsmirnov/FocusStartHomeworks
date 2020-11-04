//
//  SplitViewController.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

class SplitViewController: UISplitViewController {
    // MARK: Properties
    
    enum SplitViewDisplayMode {
        case compact
        case regular
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        let tableViewController = TableViewController()
        let detailViewController = DetailViewController()
        
        let tableNavigationController = UINavigationController(rootViewController: tableViewController)
        let detailNavigationController = UINavigationController(rootViewController: detailViewController)
        
        viewControllers = [tableNavigationController, detailNavigationController]
    }
}

// MARK: - UISplitViewControllerDelegate

extension SplitViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        return false
    }
}
