//
//  CarsViewController.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

class CarsViewController: UIViewController {
    // MARK: Delegate
    
    weak var delegate: CarsViewControllerDelegate?
    
    // MARK: Properties
    
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
        guard let cell = carsView.dequeueReusableCell(
            withIdentifier: CarCell.reuseIdentifier,
            for: indexPath
        ) as? CarCell else { return UITableViewCell() }

        if let data = data {
            let car = data.get(at: indexPath.row)
            
            cell.setCar(car)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let car = data?.get(at: indexPath.row) {
            delegate?.carsViewControllerDelegate(self, didSelect: car)
        }
        
        carsView.deselectRow(at: indexPath, animated: true)
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
            action: #selector(filterAction)
        )
        let filterStatusBarButtonItem = UIBarButtonItem(title: "None", style: .plain, target: self, action: nil)
        
        filterStatusBarButtonItem.isEnabled = false
        
        navigationItem.leftBarButtonItems = [filterBarButtonItem, filterStatusBarButtonItem]
    }
    
    func setupAddButton() {
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc func filterAction() {
        delegate?.carsViewControllerDelegateDidTapFilter(self)
    }
    
    @objc func addAction() {
        delegate?.carsViewControllerDelegateDidTapAdd(self)
    }
}
