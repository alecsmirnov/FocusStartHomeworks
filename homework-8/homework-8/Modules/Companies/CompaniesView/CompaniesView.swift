//
//  CompaniesView.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

import UIKit

protocol ICompaniesView: AnyObject {
    func insertNewRow()
    func reloadRow(at index: Int)
    func deleteRow(at index: Int)
}

final class CompaniesView: UIView {
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

extension CompaniesView {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - ICarsView

extension CompaniesView: ICompaniesView {
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

private extension CompaniesView {
    func registerCells() {
        tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.reuseIdentifier)
    }
}

// MARK: - Appearance

private extension CompaniesView {
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        setupTableViewAppearance()
    }
    
    func setupTableViewAppearance() {
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Layouts

private extension CompaniesView {
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
