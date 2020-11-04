//
//  TableViewController.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

final class TableViewController: UIViewController {
    // MARK: Delegate
    
    weak var delegate: TableViewControllerDelegate?
    
    // MARK: Properties
    
    var dataService: DataService?
    
    private var tableView: TableView {
        guard let tableView = view as? TableView else {
            fatalError("view is not a TableView instance")
        }
        
        return tableView
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = TableView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setSelectedRow(at: 0)
    }
}

// MARK: - TableView Customization

extension TableViewController {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        registerCells()
    }
    
    func registerCells() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
}

// MARK: - Private Methods

private extension TableViewController {
    func setSelectedRow(at index: Int) {
        if detailControllerExist() {
            guard let dataService = dataService else { return }
            
            if !dataService.isEmpty {
                let indexPath = IndexPath(row: index, section: 0)
                let record = dataService.get(at: index)
                
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
                delegate?.tableViewControllerDelegate(self, didSelectRecord: record)
            }
        }
    }
    
    func detailControllerExist() -> Bool {
        return splitViewController?.viewControllers.count == 2
    }
}

// MARK: - UITableViewDataSource

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.identifier,
            for: indexPath
        ) as! TableViewCell
        
        if let dataService = dataService {
            cell.customize(record: dataService.get(at: indexPath.row))
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataService = dataService else { return }
        
        let record = dataService.get(at: indexPath.row)
        
        if detailControllerExist() {
            delegate?.tableViewControllerDelegate(self, didSelectRecord: record)
        }
        else {
            let detailViewController = DetailViewController()
            detailViewController.customize(record: record)
            
            navigationController?.pushViewController(detailViewController, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
