//
//  TableViewController.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

final class TableViewController: UIViewController {
    // MARK: Properties
    
    var data: DataService?
    
    private var tableView: TableView {
        guard let tableView = view as? TableView else {
            fatalError("view is not a TableView instance")
        }
        
        return tableView
    }
    
    // MARK: Lifecycle

    override func loadView() {
        view = TableView(frame: .zero)
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
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
    }
}

// MARK: - Private Methods

private extension TableViewController {
    func setSelectedRow(at index: Int) {
        guard let splitViewController = splitViewController else { return }
        
        if !splitViewController.isCollapsed {
            if let data = data, !data.isEmpty {
                let record = data.get(at: index)
                
                customizeDetailViewController(record: record)

                let indexPath = IndexPath(row: index, section: 0)
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
        }
    }
    
    func showDetailViewController(record: Record) {
        guard let splitViewController = splitViewController else { return }
        
        let detailViewController = DetailViewController()
        detailViewController.customize(record: record)
        
        let navigationController = UINavigationController(rootViewController: detailViewController)
        splitViewController.showDetailViewController(navigationController, sender: nil)
    }
    
    func customizeDetailViewController(record: Record) {
        guard let splitViewController = splitViewController,
              let navigationController = splitViewController.viewControllers.last as? UINavigationController,
              let detailViewController = navigationController.viewControllers.first as? DetailViewController else {
            return
        }
        
        detailViewController.customize(record: record)
    }
}

// MARK: - UITableViewDataSource

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.reuseIdentifier,
            for: indexPath
        ) as? TableViewCell else {
            fatalError("cell with the specified identifier was not found")
        }

        if let data = data {
            cell.customize(record: data.get(at: indexPath.row))
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let splitViewController = splitViewController,
              let record = data?.get(at: indexPath.row) else { return }

        if splitViewController.isCollapsed {
            showDetailViewController(record: record)
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            customizeDetailViewController(record: record)
        }
    }
}
