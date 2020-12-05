//
//  EmployeesView.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

import UIKit

protocol IEmployeesView: AnyObject {
    func insertNewRow()
    func reloadRow(at index: Int)
    func deleteRow(at index: Int)
}

final class EmployeesView: UIView {
    // MARK: Properties
    
    var tableViewDataSource: UITableViewDataSource? {
        get { tableView.dataSource }
        set { tableView.dataSource = newValue }
    }
    
    var tableViewDelegate: UITableViewDelegate? {
        get { tableView.delegate }
        set { tableView.delegate = newValue }
    }
    
    // MARK: Subviews
    
    private let tableView = UITableView()
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)

        registerCells()
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension EmployeesView {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - IEmployeesView

extension EmployeesView: IEmployeesView {
    func insertNewRow() {
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
        let lastRowIndexPath = IndexPath(row: lastRowIndex, section: 0)
        
        tableView.insertRows(at: [lastRowIndexPath], with: .automatic)
    }
    
    func reloadRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func deleteRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - Private Methods

private extension EmployeesView {
    func registerCells() {
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.reuseIdentifier)
    }
}

// MARK: - Appearance

private extension EmployeesView {
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        setupTableViewAppearance()
    }
    
    func setupTableViewAppearance() {
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Layouts

private extension EmployeesView {
    func setupLayout() {
        setupSubviews()
        
        setupTableViewLayout()
    }
    
    func setupSubviews() {
        addSubview(tableView)
    }
    
    func setupTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
