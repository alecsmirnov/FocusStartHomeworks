//
//  BodyPickerView.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

final class BodyPickerView: UIView {
    // MARK: Properties
    
    var selectedBody: Body?
    
    var didSelectBody: BodySelectAction?
    
    private enum Metrics {
        static let rowHeight: CGFloat = 50
    }
    
    private var selectedIndex: IndexPath?
    private let tableView = UITableView()
    
    private let bodies = Body.allCases
    
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

// MARK: TableView

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
        return bodies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BodyCell.reuseIdentifier,
            for: indexPath
        ) as? BodyCell else {
            return UITableViewCell()
        }
        
        let body = bodies[indexPath.row]
        
        cell.body = body
        
        if selectedBody == body {
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
        if let currentCell = tableView.cellForRow(at: indexPath) as? BodyCell {
            currentCell.checked = true
        }
        
        if let previousSelectedIndex = selectedIndex, previousSelectedIndex != indexPath {
            if let previousCell = tableView.cellForRow(at: previousSelectedIndex) as? BodyCell {
                previousCell.checked = false
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let bodyCase = bodies[indexPath.row]
        
        selectedBody = bodyCase
        selectedIndex = indexPath
        
        didSelectBody?(bodyCase)
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
