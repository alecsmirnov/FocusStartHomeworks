//
//  CarsPresenterProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

protocol CarsPresenterProtocol: CarsPresenterProtocolInputOutputProtocol {
    var viewController: CarsViewControllerProtocol? { get set }
    
    var interactor: CarsInteractorProtocol? { get set }
    var router: CarsRouterProtocol? { get set }
}

protocol CarsPresenterProtocolInputOutputProtocol: AnyObject {
    var isEmpty: Bool { get }
    var count: Int { get }
    
    func append(car: Car)
    func remove(at index: Int)
    func get(at index: Int) -> Car?
    
    func didPressFilterButton(with body: Body?)
    func didPressAddButton()
    func didSelectRow(with car: Car)
}
