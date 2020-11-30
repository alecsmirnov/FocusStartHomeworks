//
//  ImageLoaderView.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

import UIKit

final class ImageLoaderView: UIView {
    typealias SearchButtonPressCompletions = (String) -> Void
    
    // MARK: Properties
    
    var searchButtonAction: SearchButtonPressCompletions?
    
    var tableViewDataSource: UITableViewDataSource? {
        get { tableView.dataSource }
        set { tableView.dataSource = newValue }
    }
    
    var tableViewDelegate: UITableViewDelegate? {
        get { tableView.delegate }
        set { tableView.delegate = newValue }
    }
    
    // MARK: Subviews

    private let searchBar = UISearchBar()
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
extension ImageLoaderView {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - Private Methods

private extension ImageLoaderView {
    func registerCells() {
        //tableView.register(CarCell.self, forCellReuseIdentifier: CarCell.reuseIdentifier)
    }
}

// MARK: - Appearance

private extension ImageLoaderView {
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        setupSearchBarAppearance()
        setupTableViewAppearance()
    }
    
    func setupSearchBarAppearance() {
        //searchBar.showsCancelButton = true
    }
    
    func setupTableViewAppearance() {
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Layouts

private extension ImageLoaderView {
    func setupLayout() {
        setupSubviews()
        
        setupSearchBarLayout()
        setupTableViewLayout()
    }
    
    func setupSubviews() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    func setupSearchBarLayout() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
