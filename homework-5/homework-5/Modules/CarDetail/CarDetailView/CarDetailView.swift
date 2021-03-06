//
//  CarDetailView.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol ICarDetailView: AnyObject {
    var didSelectBody: BodySelectAction? { get set }
    
    func setCarToEdit(_ car: Car?)
}

final class CarDetailView: UIView {
    // MARK: Properties
    
    var didSelectBody: BodySelectAction?
    
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
        case manufacturer
        case model
        case body
    }
    
    private enum TableViewOptionalSectionRow: Int {
        case yearOfIssue
        case carNumber
    }
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    // MARK: Cells
    
    private let manufacturerCell = UITableViewCell()
    private let modelCell = UITableViewCell()
    private let bodyCell = UITableViewCell()
    private let yearOfIssueCell = UITableViewCell()
    private let carNumberCell = UITableViewCell()
    
    // MARK: Subview of Cells
    
    private let manufacturerTextField = UITextField()
    private let modelTextField = UITextField()
    private let bodyLabel = UILabel()
    private let yearOfIssueTextField = UITextField()
    private let carNumberTextField = UITextField()
    
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

extension CarDetailView {
    func getCarToEdit() -> Car? {
        guard let manufacturer = manufacturerTextField.text, !manufacturer.isEmpty,
              let model = modelTextField.text, !model.isEmpty,
              let body = Body(rawValue: bodyLabel.text ?? "") else { return nil }
        
        let yearOfIssue = Int(yearOfIssueTextField.text ?? "")
        let carNumber = carNumberTextField.text

        let carToEdit = Car(
            manufacturer: manufacturer,
            model: model,
            body: body,
            yearOfIssue: yearOfIssue,
            carNumber: carNumber
        )
        
        return carToEdit
    }
    
    func setBody(_ body: Body?) {
        bodyLabel.text = body?.rawValue
    }
}

// MARK: - ICarDetailView

extension CarDetailView: ICarDetailView {
    func setCarToEdit(_ car: Car?) {
        if let car = car {
            manufacturerTextField.text = car.manufacturer
            modelTextField.text = car.model
            bodyLabel.text = car.body.rawValue
            yearOfIssueTextField.text = car.yearOfIssue?.description
            carNumberTextField.text = car.carNumber?.description
        }
    }
}

// MARK: - Appearance

private extension CarDetailView {
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
        manufacturerTextField.placeholder = "Manufacturer"
        modelTextField.placeholder = "Model"
        bodyLabel.text = "Select body"
        bodyLabel.textColor = .systemBlue
        yearOfIssueTextField.placeholder = "Year of issue"
        carNumberTextField.placeholder = "Car number"
    }
    
    func setupTableViewCellsAppearance() {
        manufacturerCell.selectionStyle = .none
        modelCell.selectionStyle = .none
        bodyCell.accessoryType = .disclosureIndicator
        yearOfIssueCell.selectionStyle = .none
        carNumberCell.selectionStyle = .none
    }
}

// MARK: - Layouts

private extension CarDetailView {
    func setupLayout() {
        setupSubviews()
        
        setupTableViewLayout()
        setupCellsLayout()
    }
    
    func setupSubviews() {
        addSubview(tableView)
        
        manufacturerCell.contentView.addSubview(manufacturerTextField)
        modelCell.contentView.addSubview(modelTextField)
        bodyCell.contentView.addSubview(bodyLabel)
        
        yearOfIssueCell.contentView.addSubview(yearOfIssueTextField)
        carNumberCell.contentView.addSubview(carNumberTextField)
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
        CarDetailView.setupSubviewCellLayout(subview: manufacturerTextField, cell: manufacturerCell)
        CarDetailView.setupSubviewCellLayout(subview: modelTextField, cell: modelCell)
        CarDetailView.setupSubviewCellLayout(subview: bodyLabel, cell: bodyCell)
        CarDetailView.setupSubviewCellLayout(subview: yearOfIssueTextField, cell: yearOfIssueCell)
        CarDetailView.setupSubviewCellLayout(subview: carNumberTextField, cell: carNumberCell)
    }
    
    static func setupSubviewCellLayout(subview: UIView, cell: UITableViewCell) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: Metrics.horizontalSpace),
            subview.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -Metrics.horizontalSpace),
            subview.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: Metrics.verticalSpace),
            subview.trailingAnchor.constraint(
                equalTo: cell.contentView.trailingAnchor,
                constant: -Metrics.verticalSpace
            ),
        ])
    }
}

// MARK: - Gesture Recognizer

extension CarDetailView {
    func setupTapGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGestureRecognizer?.cancelsTouchesInView = false
        
        if let tapGestureRecognizer = tapGestureRecognizer {
            tableView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func hideKeyboard() {
        endEditing(true)
    }
}

// MARK: - UITableViewDataSource

extension CarDetailView: UITableViewDataSource {
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
            case .manufacturer?: return manufacturerCell
            case .model?: return modelCell
            case .body?: return bodyCell
            case .none: return UITableViewCell()
            }
        case .optional?:
            let row = TableViewOptionalSectionRow(rawValue: indexPath.row)
            
            switch row {
            case .yearOfIssue?: return yearOfIssueCell
            case .carNumber?: return carNumberCell
            case .none: return UITableViewCell()
            }
        case .none: return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension CarDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let section = TableViewSection(rawValue: indexPath.section), section == .required,
           let row = TableViewRequiredSectionRow(rawValue: indexPath.row), row == .body {
            tableView.deselectRow(at: indexPath, animated: true)
            
            didSelectBody?(Body(rawValue: bodyLabel.text ?? ""))
        }
    }
}
