//
//  EmployeeCell.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

import UIKit

protocol IEmployeeCell: AnyObject {}

final class EmployeeCell: UITableViewCell {
    // MARK: Properties
    
    static let reuseIdentifier = String(describing: self)
    
    private enum Metrics {
        static let horizontalSpace: CGFloat = 16
        static let verticalSpace: CGFloat = 8
    }
    
    // MARK: Subviews
    
    private let nameLabel = UILabel()
    private let ageLabel = UILabel()
    private let postLabel = UILabel()
    
    private let workExperienceLabel = UILabel()
    private let educationLabel = UILabel()
    
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

extension EmployeeCell {
    func configure(with employee: Employee) {
        nameLabel.text = "Name: \(employee.name)"
        ageLabel.text = "Age: \(employee.age)"
        postLabel.text = "Post: \(employee.post)"
        
        let workExperience = employee.workExperience == nil ? "-" : employee.workExperience ?? ""
        let education = employee.education == nil ? "-" : employee.education ?? ""
        
        workExperienceLabel.text = "Work experience: \(workExperience)"
        educationLabel.text = "Education: \(education)"
    }
}

// MARK: - IEmployeeCell

extension EmployeeCell: IEmployeeCell {}

// MARK: - Appearance

private extension EmployeeCell {
    func setupAppearance() {
        
    }
}

// MARK: - Layout

private extension EmployeeCell {
    func setupLayout() {
        setupSubviews()
        
        setupNameLabelLayout()
        setupAgeLabelLayout()
        setupPostLabelLayout()
        
        setupWorkExperienceLabelLayout()
        setupEducationLabelLayout()
    }
    
    func setupSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(postLabel)
        
        contentView.addSubview(workExperienceLabel)
        contentView.addSubview(educationLabel)
    }
    
    func setupNameLabelLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.verticalSpace),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.horizontalSpace),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -Metrics.horizontalSpace),
        ])
    }
    
    func setupAgeLabelLayout() {
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Metrics.verticalSpace),
            ageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.horizontalSpace),
            ageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.horizontalSpace),
        ])
    }
    
    func setupPostLabelLayout() {
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: Metrics.verticalSpace),
            postLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.horizontalSpace),
            postLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -Metrics.horizontalSpace),
        ])
    }

    func setupWorkExperienceLabelLayout() {
        workExperienceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workExperienceLabel.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: Metrics.verticalSpace),
            workExperienceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                         constant: Metrics.horizontalSpace),
            workExperienceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                          constant: -Metrics.horizontalSpace),
        ])
    }
    
    func setupEducationLabelLayout() {
        educationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            educationLabel.topAnchor.constraint(equalTo: workExperienceLabel.bottomAnchor,
                                                constant: Metrics.verticalSpace),
            educationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                   constant: -Metrics.verticalSpace),
            educationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: Metrics.horizontalSpace),
            educationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -Metrics.horizontalSpace),
        ])
    }
}
