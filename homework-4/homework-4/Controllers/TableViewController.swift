//
//  TableViewController.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

protocol TableViewControllerDelegate: AnyObject {
    func tableViewControllerDelegate(_ tableViewController: UIViewController, didSelect record: Record)
}

final class TableViewController: UIViewController {
    // MARK: Delegate
    
    weak var delegate: TableViewControllerDelegate?
    
    // MARK: Properties
    
    var data: DataService?
    
    var selectedRow: Int?
    
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
        selectRow(at: selectedRow)
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
    func selectRow(at index: Int?) {
        if let index = index {
            guard let splitViewController = splitViewController, !splitViewController.isCollapsed else { return }
            
            if  0 <= index && index < data?.count ?? 0 {
                let indexPath = IndexPath(row: index, section: 0)
            
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
        } else if let previousRowIndex = selectedRow {
            let indexPath = IndexPath(row: previousRowIndex, section: 0)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
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
        ) as? TableViewCell else { return UITableViewCell() }

        if let data = data {
            cell.customize(record: data.get(at: indexPath.row))
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let record = data?.get(at: indexPath.row) {
            delegate?.tableViewControllerDelegate(self, didSelect: record)
        }
    }
}
