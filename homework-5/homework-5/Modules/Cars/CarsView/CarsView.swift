//
//  CarsView.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol ICarsView: AnyObject {    
    func insertNewRow()
    func reloadRow(at index: Int)
    func deleteRow(at index: Int)
    func reloadData()
}

final class CarsView: UIView {
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

// MARK: - ICarsView Protocol

extension CarsView: ICarsView {
    var tableViewDataSource: UITableViewDataSource? {
        get { tableView.dataSource }
        set { tableView.dataSource = newValue }
    }
    
    var tableViewDelegate: UITableViewDelegate? {
        get { tableView.delegate }
        set { tableView.delegate = newValue }
    }
    
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
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - Private Methods

private extension CarsView {
    func registerCells() {
        tableView.register(CarCell.self, forCellReuseIdentifier: CarCell.reuseIdentifier)
    }
}

// MARK: - Appearance

private extension CarsView {
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        setupTableViewAppearance()
    }
    
    func setupTableViewAppearance() {
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Layouts

private extension CarsView {
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
