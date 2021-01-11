//
//  NewCompanyRouter.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

import UIKit

protocol INewCompanyRouter: AnyObject {
    func closeNewCompanyViewController()
}

final class NewCompanyRouter {
    private weak var viewController: NewCompanyViewController?
    
    init(viewController: NewCompanyViewController) {
        self.viewController = viewController
    }
}

// MARK: - INewCompanyRouter

extension NewCompanyRouter: INewCompanyRouter {
    func closeNewCompanyViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
