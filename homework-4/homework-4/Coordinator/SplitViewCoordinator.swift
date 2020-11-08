//
//  SplitViewCoordinator.swift
//  homework-4
//
//  Created by Admin on 08.11.2020.
//

import UIKit

final class SplitViewCoordinator {
    private let splitViewController: UISplitViewController
    
    init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
        
        setupSplitViewController()
    }
}

// MARK: - SplitViewController Settings

private extension SplitViewCoordinator {
    func setupSplitViewController() {
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = .oneBesideSecondary
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let data = DataService.mockObject()
        
        let tableViewController = TableViewController()
        let detailViewController = DetailViewController()
        
        let tableNavigationController = UINavigationController(rootViewController: tableViewController)
        let detailNavigationController = UINavigationController(rootViewController: detailViewController)
        
        splitViewController.viewControllers = [tableNavigationController, detailNavigationController]
        
        tableViewController.delegate = self
        tableViewController.data = data
        
        if !data.isEmpty {
            tableViewController.selectedRow = 0
            detailViewController.customize(record: data.get(at: 0))
        }
        
    }
}

// MARK: - Navigation

extension SplitViewCoordinator {
    func showDetailViewController(record: Record) {
        if splitViewController.isCollapsed {
            pushDetailViewController(record: record)
        } else {
            customizeDetailViewController(record: record)
        }
    }
    
    func pushDetailViewController(record: Record) {
        let detailViewController = DetailViewController()
        let navigationController = UINavigationController(rootViewController: detailViewController)
        
        detailViewController.customize(record: record)
        
        splitViewController.showDetailViewController(navigationController, sender: nil)
    }
    
    func customizeDetailViewController(record: Record) {
        guard let navigationController = splitViewController.viewControllers.last as? UINavigationController,
              let detailViewController = navigationController.viewControllers.first as? DetailViewController else {
            return
        }
        
        detailViewController.customize(record: record)
    }
}

// MARK: - UISplitViewControllerDelegate

extension SplitViewCoordinator: UISplitViewControllerDelegate {
    func splitViewController(
        _ svc: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column
    ) -> UISplitViewController.Column {
        return .primary
    }
}

// MARK: - TableViewControllerDelegate

extension SplitViewCoordinator: TableViewControllerDelegate {
    func tableViewControllerDelegate(_ tableViewController: UIViewController, didSelect record: Record) {
        showDetailViewController(record: record)
    }
}
