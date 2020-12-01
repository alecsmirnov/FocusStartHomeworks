//
//  ImageLoaderAssembly.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

enum ImageLoaderAssembly {
    static func createImageLoaderViewController() -> ImageLoaderViewController {
        let viewController = ImageLoaderViewController()
        
        let interactor = ImageLoaderInteractor()
        let presenter = ImageLoaderPresenter()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        
        return viewController
    }
}
