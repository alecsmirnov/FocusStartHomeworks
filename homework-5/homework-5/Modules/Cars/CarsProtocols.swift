//
//  CarsProtocols.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

import UIKit

// MARK: - Cell

protocol CarCellProtocol: AnyObject {
    func configure(with car: Car)
}

// MARK: - View

protocol CarsViewProtocol: AnyObject {
    var dataSource: UITableViewDataSource? { get set }
    var delegate: UITableViewDelegate? { get set }
 
    func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String)
    //func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell
    
    func selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition)
    //func deselectRow(at indexPath: IndexPath, animated: Bool)
}

// MARK: - ViewController

protocol CarsViewControllerProtocol: AnyObject {
    var presenter: CarsPresenterProtocol? { get set }
    
    // Presenter -> View
    
    var filter: Body? { get set }
    var data: CarService? { get set }
    
    func applyFilter()
    func resetFilter()
}

// MARK: - Interactor

protocol CarsInteractorProtocol: AnyObject {
    var presenter: CarsPresenterProtocol? { get set }
    
//    // Presenter -> Interactor
//    
//    var isEmpty: Bool { get }
//    var count: Int { get }
//    
//    // Interactor -> Presenter
//    
//    func append(car: Car)
//    func get(at index: Int) -> Car
    
    func getData() -> CarService
}

// MARK: - Presenter

protocol CarsPresenterProtocol: AnyObject {
    var viewController: CarsViewControllerProtocol? { get set }
    
    var interactor: CarsInteractorProtocol? { get set }
    var router: CarsRouterProtocol? { get set }
    
    // View -> Presenter
    
    func didPressFilterButton(with body: Body?)
    func didPressAddButton()
    func didSelectRow(with car: Car)
    
    func setData()
}

// MARK: - Router

protocol CarsRouterProtocol: AnyObject {
    static func createCarsNavigationController() -> UINavigationController
    
    // Presenter -> Router
    
    func openFilterViewController(from viewController: CarsViewControllerProtocol, with body: Body?)
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol, with car: Car?)
}

extension CarsRouterProtocol {
    func openFilterViewController(from viewController: CarsViewControllerProtocol) {
        openFilterViewController(from: viewController, with: nil)
    }
    
    func openCarDetailViewController(from viewController: CarsViewControllerProtocol) {
        openCarDetailViewController(from: viewController, with: nil)
    }
}
