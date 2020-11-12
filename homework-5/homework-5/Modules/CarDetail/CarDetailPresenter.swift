//
//  CarDetailPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import Foundation

protocol CarDetailPresenterProtocol: AnyObject {
    var viewController: CarDetailViewControllerProtocol? { get set }
    
    var interactor: CarDetailInteractorProtocol? { get set }
    var router: CarDetailRouterProtocol? { get set }
}

final class CarDetailPresenter: CarDetailPresenterProtocol {
    weak var viewController: CarDetailViewControllerProtocol?
    
    var interactor: CarDetailInteractorProtocol?
    var router: CarDetailRouterProtocol?
}
