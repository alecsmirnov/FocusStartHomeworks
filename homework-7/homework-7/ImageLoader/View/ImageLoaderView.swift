//
//  ImageLoaderView.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

import UIKit

protocol IImageLoaderView: AnyObject {}

protocol ImageLoaderViewDelegate: AnyObject {
    func imageLoaderViewSearchButtonPressed(_ imageLoaderView: ImageLoaderView, text: String)
}

final class ImageLoaderView: UIView {
    typealias SearchButtonPressCompletions = (String) -> Void
    
    // MARK: Properties
    
    weak var delegate: ImageLoaderViewDelegate?
    
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
        setupDelegates()
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IImageLoaderView

extension ImageLoaderView: IImageLoaderView {}

// MARK: - Public Methods

extension ImageLoaderView {
    func insertNewRow() {
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
        let lastRowIndexPath = IndexPath(row: lastRowIndex, section: 0)
        
        tableView.insertRows(at: [lastRowIndexPath], with: .automatic)
    }
    
    func deleteRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func indexPath(for cell: UITableViewCell) -> IndexPath? {
        return tableView.indexPath(for: cell)
    }
    
    func cellForRow(at index: Int) -> UITableViewCell? {
        let indexPath = IndexPath(row: index, section: 0)
        
        return tableView.cellForRow(at: indexPath)
    }
    
    func beginUpdates() {
        tableView.beginUpdates()
    }
    
    func endUpdates() {
        tableView.endUpdates()
    }
}

// MARK: - Private Methods

private extension ImageLoaderView {
    func registerCells() {
        tableView.register(ImageLoaderCell.self, forCellReuseIdentifier: ImageLoaderCell.reuseIdentifier)
    }
    
    func setupDelegates() {
        searchBar.delegate = self
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
        searchBar.setValue("Search", forKey: "cancelButtonText")
    }
    
    func setupTableViewAppearance() {
        tableView.tableFooterView = UIView()
        tableView.delaysContentTouches = false
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

// MARK: - UISearchBarDelegate

extension ImageLoaderView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            delegate?.imageLoaderViewSearchButtonPressed(self, text: text)
        }
        
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            delegate?.imageLoaderViewSearchButtonPressed(self, text: text)
        }
        
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = searchText.isEmpty ? false : true
    }
}
