//
//  CompanyCell.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

import UIKit

protocol ICompanyCell: AnyObject {}

final class CompanyCell: UITableViewCell {
    // MARK: Properties
    
    static let reuseIdentifier = String(describing: self)
    
    private enum Metrics {
        static let horizontalSpace: CGFloat = 16
        static let verticalSpace: CGFloat = 8
         
        static let nameLabelSize: CGFloat = 20
        static let employeesLabelSize: CGFloat = 12
    }
    
    // MARK: Subviews
    
    private let companyNameLabel = UILabel()
    private let employeesCountLabel = UILabel()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension CompanyCell {
    func configure(with company: Company) {
        companyNameLabel.text = company.name
        employeesCountLabel.text = "Employees: \(company.employees.count)"
    }
}

// MARK: - ICompanyCell

extension CompanyCell: ICompanyCell {}

// MARK: - Appearance

private extension CompanyCell {
    func setupAppearance() {
        setupCompanyNameLabelAppearance()
        setupEmployeesCountLabelAppearance()
    }
    
    func setupCompanyNameLabelAppearance() {
        companyNameLabel.font = .boldSystemFont(ofSize: Metrics.nameLabelSize)
    }
    
    func setupEmployeesCountLabelAppearance() {
        employeesCountLabel.font = .systemFont(ofSize: Metrics.employeesLabelSize)
        employeesCountLabel.text = "Employees: 0"
    }
}

// MARK: - Layout

private extension CompanyCell {
    func setupLayout() {
        setupSubviews()
        
        setupCompanyNameLabelLayout()
        setupEmployeesCountLabelLayout()
    }
    
    func setupSubviews() {
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(employeesCountLabel)
    }
    
    func setupCompanyNameLabelLayout() {
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.verticalSpace),
            companyNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                     constant: -Metrics.verticalSpace),
            companyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                      constant: Metrics.horizontalSpace),
        ])
    }
    
    func setupEmployeesCountLabelLayout() {
        employeesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            employeesCountLabel.centerYAnchor.constraint(equalTo: companyNameLabel.centerYAnchor),
            employeesCountLabel.leadingAnchor.constraint(equalTo: companyNameLabel.trailingAnchor,
                                                         constant: Metrics.horizontalSpace),
            employeesCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                          constant: -Metrics.horizontalSpace),
        ])
    }
}
