//
//  CarsViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

final class CarsViewController: UIViewController {
    // MARK: Properties
    
    weak var presenter: CarsPresenterProtocol?
    
    var filter: Body?
    var data: CarService?
    
    private var carsView: CarsView {
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

// MARK: - CarsViewControllerProtocol

extension CarsViewController: CarsViewControllerProtocol {
    func applyFilter() {
        
    }
    
    func resetFilter() {
        
    }
}

// MARK: - Public Methods

extension CarsViewController {
    func setFilter(body: Body?) {
        if let filterStatusBarButtonItem = navigationItem.leftBarButtonItems?.last {
            filterStatusBarButtonItem.title = body?.rawValue ?? "None"
        }
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

// MARK: - UITableViewDataSource

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CarCell.reuseIdentifier,
            for: indexPath
        ) as? CarCell else { return UITableViewCell() }

        if let data = data {
            let car = data.get(at: indexPath.row)
            
            cell.configure(with: car)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let car = data?.get(at: indexPath.row) {
            presenter?.didSelectRow(with: car)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Actions

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
    
    @objc func didPressFilterButton() {
        presenter?.didPressFilterButton(with: filter)
    }
    
    @objc func didPressAddButton() {
        presenter?.didPressAddButton()
    }
}
