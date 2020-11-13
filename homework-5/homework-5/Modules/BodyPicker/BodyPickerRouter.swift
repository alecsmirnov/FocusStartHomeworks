//
//  BodyPickerRouter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

final class BodyPickerRouter: BodyPickerRouterProtocol {
    static func createBodyPickerViewController(with body: Body?) -> UIViewController {
        let bodyPickerViewController = BodyPickerViewController()
        
        let interactor = BodyPickerInteractor()
        let presenter = BodyPickerPresenter()
        let router = BodyPickerRouter()
        
        bodyPickerViewController.presenter = presenter
        bodyPickerViewController.selectedBody = body
        
        interactor.presenter = presenter
        
        presenter.viewController = bodyPickerViewController
        presenter.interactor = interactor
        presenter.router = router
         
        return bodyPickerViewController
    }
    
    func closeBodyPickerViewController(_ viewController: BodyPickerViewControllerProtocol) {
        guard let viewController = viewController as? UIViewController else { return }
        
        if viewController.presentingViewController != nil {
            viewController.dismiss(animated: true, completion: nil)
        } else {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
}
