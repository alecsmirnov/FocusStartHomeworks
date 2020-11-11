//
//  BodyPickerView.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol IBodyPickerView {
    // MARK: Input
    
    var bodyToSelect: Body? { get set }
    
    // MARK: Output
    
    var didSelectBody: BodySelectAction? { get set }
}

final class BodyPickerView: UIView, IBodyPickerView {
    // MARK: Properties
    
    var bodyToSelect: Body?
    
    var didSelectBody: BodySelectAction?
    
    private enum Metrics {
        static let rowHeight: CGFloat = 50
    }
    
    private var selectedIndex: IndexPath?
    private let tableView = UITableView()
    
    private let bodyCases = Body.allCases
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)

        setupTableView()
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private Methods

private extension BodyPickerView {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        registerCells()
    }
    
    func registerCells() {
        tableView.register(BodyCell.self, forCellReuseIdentifier: BodyCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource

extension BodyPickerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bodyCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BodyCell.reuseIdentifier,
            for: indexPath
        ) as? BodyCell else {
            return UITableViewCell()
        }
        
        let body = bodyCases[indexPath.row]
        
        cell.bodyToSelect = body
        
        if bodyToSelect == body {
            cell.checked = true
            selectedIndex = indexPath
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BodyPickerView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousSelectedIndex = selectedIndex, previousSelectedIndex != indexPath {
            if let currentCell = tableView.cellForRow(at: indexPath) as? BodyCell {
                currentCell.checked = true
            }
            
            if let previousCell = tableView.cellForRow(at: previousSelectedIndex) as? BodyCell {
                previousCell.checked = false
            }
            
            selectedIndex = indexPath
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        didSelectBody?(bodyCases[indexPath.row])
    }
}

// MARK: - Appearance

private extension BodyPickerView {
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        setupTableViewAppearance()
    }
    
    func setupTableViewAppearance() {
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Layouts

private extension BodyPickerView {
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
