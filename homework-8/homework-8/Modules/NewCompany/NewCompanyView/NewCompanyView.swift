//
//  NewCompanyView.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

import UIKit

protocol INewCompanyView: AnyObject {}

final class NewCompanyView: UIView {
    // MARK: Properties
    
    private enum Metrics {
        static let rowHeight: CGFloat = 50
        
        static let horizontalSpace: CGFloat = 16
        static let verticalSpace: CGFloat = 8
    }
    
    private enum TableViewSection: Int, CaseIterable {
        case required
        
        func numberOfRows() -> Int {
            switch self {
            case .required: return 1
            }
        }
        
        func title() -> String {
            switch self {
            case .required: return "Required"
            }
        }
    }
    
    private enum TableViewRequiredSectionRow: Int {
        case name
    }
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: Cells
    
    private let nameCell = UITableViewCell()
    
    // MARK: Subview of Cells
    
    private let nameTextField = UITextField()
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)

        setupAppearance()
        setupLayout()
        setupTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension NewCompanyView {
    var nameText: String? {
        return nameTextField.text
    }
}

// MARK: - INewCompanyView

extension NewCompanyView: INewCompanyView {}

// MARK: - Appearance

private extension NewCompanyView {
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        setupTableViewAppearance()
        setupTableViewSubviewsCellsAppearance()
        setupTableViewCellsAppearance()
    }
    
    func setupTableViewAppearance() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupTableViewSubviewsCellsAppearance() {
        nameTextField.placeholder = "Name"
    }
    
    func setupTableViewCellsAppearance() {
        nameCell.selectionStyle = .none
    }
}

// MARK: - Layouts

private extension NewCompanyView {
    func setupLayout() {
        setupSubviews()
        
        setupTableViewLayout()
        setupCellsLayout()
    }
    
    func setupSubviews() {
        addSubview(tableView)
        
        nameCell.contentView.addSubview(nameTextField)
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
    
    func setupCellsLayout() {
        NewCompanyView.setupSubviewCellLayout(subview: nameTextField, cell: nameCell)
    }
    
    static func setupSubviewCellLayout(subview: UIView, cell: UITableViewCell) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: Metrics.horizontalSpace),
            subview.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -Metrics.horizontalSpace),
            subview.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: Metrics.verticalSpace),
            subview.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor,
                                              constant: -Metrics.verticalSpace),
        ])
    }
}

// MARK: - Gesture Recognizer

extension NewCompanyView {
    func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        
        tableView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        endEditing(true)
    }
}

// MARK: - UITableViewDataSource

extension NewCompanyView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewSection(rawValue: section)?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TableViewSection(rawValue: section)?.title()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = TableViewSection(rawValue: indexPath.section)
        
        switch section {
        case .required?:
            let row = TableViewRequiredSectionRow(rawValue: indexPath.row)
            
            switch row {
            case .name?: return nameCell
            case .none: return UITableViewCell()
            }
        case .none: return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension NewCompanyView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.rowHeight
    }
}
