//
//  CarsView.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

final class CarsView: UIView {
    // MARK: Properties
    
    private let tableView = UITableView()
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)

        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CarsViewProtocol

extension CarsView: CarsViewProtocol {
    var dataSource: UITableViewDataSource? {
        get { tableView.dataSource }
        set { tableView.dataSource = newValue }
    }
    
    var delegate: UITableViewDelegate? {
        get { tableView.delegate }
        set { tableView.delegate = newValue }
    }
    
    func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition) {
        tableView.selectRow(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    func deselectRow(at indexPath: IndexPath, animated: Bool) {
        tableView.deselectRow(at: indexPath, animated: animated)
    }
    
    func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        tableView.insertRows(at: indexPaths, with: animation)
    }
    
    func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        tableView.reloadRows(at: indexPaths, with: animation)
    }
    
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        tableView.deleteRows(at: indexPaths, with: animation)
    }
    
    func reloadData() {
        tableView.reloadData()
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
