//
//  CarsViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol CarsViewControllerProtocol: AnyObject {
    var presenter: CarsPresenterProtocol? { get set }
    
    var filter: Body? { get set }
}

final class CarsViewController: UIViewController, CarsViewControllerProtocol {
    // MARK: Properties
    
    weak var presenter: CarsPresenterProtocol?
    
    var filter: Body? {
        didSet {
            applyFilter(with: filter)
        }
    }
    
    private var carsView: CarsViewProtocol {
        guard let view = view as? CarsView else {
            fatalError("view is not a CarsView instance")
        }
        
        return view
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = CarsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCarsView()
        setupButtons()
    }
}

// MARK: - CarsView Customization

extension CarsViewController {
    func setupCarsView() {
        carsView.dataSource = self
        carsView.delegate = self
        
        registerCells()
    }
    
    func registerCells() {
        carsView.register(CarCell.self, forCellReuseIdentifier: CarCell.reuseIdentifier)
    }
}

// MARK: - Buttons

private extension CarsViewController {
    func setupButtons() {
        setupFilterButton()
        setupAddButton()
    }
    
    func setupFilterButton() {
        let filterBarButtonItem = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(didPressFilterButton)
        )
        
        let filterStatusBarButtonItem = UIBarButtonItem(title: "None", style: .plain, target: self, action: nil)
        filterStatusBarButtonItem.isEnabled = false
        
        navigationItem.leftBarButtonItems = [filterBarButtonItem, filterStatusBarButtonItem]
    }
    
    func setupAddButton() {
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressAddButton)
        )
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

// MARK: - Actions

extension CarsViewController {
    @objc func didPressFilterButton() {
        presenter?.didPressFilterButton(with: filter)
    }
    
    @objc func didPressAddButton() {
        presenter?.didPressAddButton()
    }
}

// MARK: - Filter

private extension CarsViewController {
    func applyFilter(with body: Body?) {
        if let _ = body {
            
        } else {
            
        }
        
        setFilterTitle(with: body)
    }
    
    func setFilterTitle(with body: Body?) {
        if let filterStatusBarButtonItem = navigationItem.leftBarButtonItems?.last {
            filterStatusBarButtonItem.title = body?.rawValue ?? "None"
        }
    }
}

// MARK: - UITableViewDataSource

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CarCell.reuseIdentifier,
            for: indexPath
        ) as? CarCell else { return UITableViewCell() }

        if let car = presenter?.get(at: indexPath.row) {
            cell.configure(with: car)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let car = presenter?.get(at: indexPath.row) {
            presenter?.didSelectRow(with: car)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
