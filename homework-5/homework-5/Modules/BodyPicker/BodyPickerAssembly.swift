//
//  BodyPickerAssembly.swift
//  homework-5
//
//  Created by Admin on 15.11.2020.
//

import UIKit

enum BodyPickerAssembly {
    static func createBodyPickerViewController(
        with body: Body?,
        delegate: BodyPickerViewControllerDelegate? = nil
    ) -> BodyPickerViewController {
        let viewController = BodyPickerViewController()
        
        let interactor = BodyPickerInteractor()
        let presenter = BodyPickerPresenter()
        let router = BodyPickerRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = router
        
        interactor.setBody(body)
        presenter.delegate = delegate
        
        return viewController
    }
}
