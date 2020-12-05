//
//  EmployeeDetailView.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

import UIKit

protocol IEmployeeDetailView: AnyObject {}

final class EmployeeDetailView: UIView {
    // MARK: Properties
    
    private enum Metrics {
        static let rowHeight: CGFloat = 50
        
        static let horizontalSpace: CGFloat = 16
        static let verticalSpace: CGFloat = 8
    }
    
    private enum TableViewSection: Int, CaseIterable {
        case required
        case optional
        
        func numberOfRows() -> Int {
            switch self {
            case .required: return 3
            case .optional: return 2
            }
        }
        
        func title() -> String {
            switch self {
            case .required: return "Required"
            case .optional: return "Optional"
            }
        }
    }
    
    private enum TableViewRequiredSectionRow: Int {
        case name
        case age
        case post
    }
    
    private enum TableViewOptionalSectionRow: Int {
        case workExperience
        case education
    }
    
    private let tableView = UITableView(frame: .zero, style: .grouped)

    // MARK: Cells
    
    private let nameCell = UITableViewCell()
    private let ageCell = UITableViewCell()
    private let postCell = UITableViewCell()
    private let workExperienceCell = UITableViewCell()
    private let educationCell = UITableViewCell()
    
    // MARK: Subview of Cells
    
    private let nameTextField = UITextField()
    private let ageTextField = UITextField()
    private let postTextField = UITextField()
    private let workExperienceTextField = UITextField()
    private let educationTextField = UITextField()
    
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

extension EmployeeDetailView {
    func setEmployee(_ employee: Employee?) {
        guard let employee = employee else { return }
        
        nameTextField.text = employee.name
        ageTextField.text = String(employee.age)
        postTextField.text = employee.post
        
        workExperienceTextField.text = employee.workExperience
        educationTextField.text = employee.education
    }
    
    func getEmployee() -> Employee? {
        guard let name = nameTextField.text, !name.isEmpty,
              let age = ageTextField.text, !age.isEmpty,
              let post = postTextField.text, !post.isEmpty else { return nil }
        
        let workExperience = workExperienceTextField.text
        let education = educationTextField.text
        
        return Employee(name: name,
                        age: Int(age) ?? 0,
                        post: post,
                        workExperience: workExperience,
                        education: education)
    }
}

// MARK: - IEmployeeDetailView

extension EmployeeDetailView: IEmployeeDetailView {}

// MARK: - Appearance

private extension EmployeeDetailView {
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
        ageTextField.placeholder = "Age"
        postTextField.placeholder = "Post"
        
        workExperienceTextField.placeholder = "Work experience"
        educationTextField.placeholder = "Education"
    }
    
    func setupTableViewCellsAppearance() {
        nameTextField.autocorrectionType = .no
        ageTextField.autocorrectionType = .no
        postTextField.autocorrectionType = .no
        workExperienceTextField.autocorrectionType = .no
        educationTextField.autocorrectionType = .no
        
        nameCell.selectionStyle = .none
        ageCell.selectionStyle = .none
        postCell.selectionStyle = .none
        workExperienceCell.selectionStyle = .none
        educationCell.selectionStyle = .none
    }
}

// MARK: - Layouts

private extension EmployeeDetailView {
    func setupLayout() {
        setupSubviews()
        
        setupTableViewLayout()
        setupCellsLayout()
    }
    
    func setupSubviews() {
        addSubview(tableView)
        
        nameCell.contentView.addSubview(nameTextField)
        ageCell.contentView.addSubview(ageTextField)
        postCell.contentView.addSubview(postTextField)
        
        workExperienceCell.contentView.addSubview(workExperienceTextField)
        educationCell.contentView.addSubview(educationTextField)
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
        EmployeeDetailView.setupSubviewCellLayout(subview: nameTextField, cell: nameCell)
        EmployeeDetailView.setupSubviewCellLayout(subview: ageTextField, cell: ageCell)
        EmployeeDetailView.setupSubviewCellLayout(subview: postTextField, cell: postCell)
        EmployeeDetailView.setupSubviewCellLayout(subview: workExperienceTextField, cell: workExperienceCell)
        EmployeeDetailView.setupSubviewCellLayout(subview: educationTextField, cell: educationCell)
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

extension EmployeeDetailView {
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

extension EmployeeDetailView: UITableViewDataSource {
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
            case .age?: return ageCell
            case .post?: return postCell
            case .none: return UITableViewCell()
            }
        case .optional?:
            let row = TableViewOptionalSectionRow(rawValue: indexPath.row)
            
            switch row {
            case .workExperience?: return workExperienceCell
            case .education?: return educationCell
            case .none: return UITableViewCell()
            }
        case .none: return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension EmployeeDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.rowHeight
    }
}
