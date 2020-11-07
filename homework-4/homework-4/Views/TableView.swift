//
//  TableView.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

final class TableView: UIView {
    // MARK: Properties
    
    var dataSource: UITableViewDataSource? {
        get { tableView.dataSource }
        set { tableView.dataSource = newValue }
    }
    
    var delegate: UITableViewDelegate? {
        get { tableView.delegate }
        set { tableView.delegate = newValue }
    }
    
    var dataPresented: Bool = true {
        didSet { dataPresented == true ? showTableView() : showEmptyDataLabel() }
    }
    
    // MARK: Subviews
    
    private let tableView = UITableView()
    
    private let emptyDataLabel = UILabel()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        showTableView()
        
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension TableView {
    func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition) {
        tableView.selectRow(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    func deselectRow(at indexPath: IndexPath, animated: Bool) {
        tableView.deselectRow(at: indexPath, animated: animated)
    }
}

// MARK: - Presentation

private extension TableView {
    func showTableView() {
        tableView.isHidden = false
        emptyDataLabel.isHidden = true
    }
    
    func showEmptyDataLabel() {
        tableView.isHidden = true
        emptyDataLabel.isHidden = false
    }
}

// MARK: - Appearance

private extension TableView {
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        setupTableViewAppearance()
        setupEmptyDataLabelAppearance()
    }
    
    func setupTableViewAppearance() {
        tableView.tableFooterView = UIView()
    }
    
    func setupEmptyDataLabelAppearance() {
        emptyDataLabel.text = "Table is empty"
        emptyDataLabel.textAlignment = .center
        emptyDataLabel.sizeToFit()
    }
}

// MARK: - Layouts

private extension TableView {
    func setupLayout() {
        setupSubviews()
        
        setupTableViewLayout()
        setupEmptyDataLabelLayout()
    }
    
    func setupSubviews() {
        addSubview(tableView)
        addSubview(emptyDataLabel)
    }
    
    func setupTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupEmptyDataLabelLayout() {
        emptyDataLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emptyDataLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            emptyDataLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            emptyDataLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
