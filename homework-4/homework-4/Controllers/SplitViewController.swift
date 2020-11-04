//
//  SplitViewController.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

final class SplitViewController: UISplitViewController {
    // MARK: Properties
    
    enum SplitViewDisplayMode {
        case compact
        case regular
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    // MARK: Initialization
    
    init(mainViewController: UIViewController, detailViewController: UIViewController) {
        super.init(style: .doubleColumn)
        
        viewControllers = [mainViewController, detailViewController]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UISplitViewControllerDelegate

extension SplitViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _ svc: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column
    ) -> UISplitViewController.Column {
        return .primary
    }
}
