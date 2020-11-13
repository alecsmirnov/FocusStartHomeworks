//
//  CarDetailPresenterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarDetailPresenterProtocol: CarDetailPresenterInputProtocol {
    var viewController: CarDetailViewControllerProtocol? { get set }
    
    var interactor: CarDetailInteractorProtocol? { get set }
    var router: CarDetailRouterProtocol? { get set }
}

protocol CarDetailPresenterInputProtocol: AnyObject {
    func didPressBodyButton(with body: Body?)
}
