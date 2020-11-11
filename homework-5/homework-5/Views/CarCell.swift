//
//  CarCell.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

final class CarCell: UITableViewCell {
    // MARK: Properties
    
    static let reuseIdentifier = String(describing: self)
    
    private enum Metrics {
        static let horizontalSpace: CGFloat = 16
        static let verticalSpace: CGFloat = 8
         
        static let titleLabelSize: CGFloat = 20
    }
    
    // MARK: Subviews
    
    private let manufacturerModelLabel = UILabel()
    private let bodyConstantLabel = UILabel()
    private let bodyLabel = UILabel()
    private let yearOfIssueConstantLabel = UILabel()
    private let yearOfIssueLabel = UILabel()
    
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

extension CarCell {
    func setCar(_ car: Car) {
        manufacturerModelLabel.text = "\(car.manufacturer)  \(car.model)"
        bodyLabel.text = car.body.rawValue
        yearOfIssueLabel.text = car.yearOfIssue?.description ?? "-"
    }
}

// MARK: - Appearance

private extension CarCell {
    func setupAppearance() {
        setupManufacturerModelLabelAppearance()
        
        setupBodyConstantLabelAppearance()
        setupYearOfIssueConstantLabelAppearance()
    }
    
    func setupManufacturerModelLabelAppearance() {
        manufacturerModelLabel.font = .boldSystemFont(ofSize: Metrics.titleLabelSize)
    }
    
    func setupBodyConstantLabelAppearance() {
        bodyConstantLabel.text = "Body:"
    }
    
    func setupYearOfIssueConstantLabelAppearance() {
        yearOfIssueConstantLabel.text = "Year:"
    }
}

// MARK: - Layout

private extension CarCell {
    func setupLayout() {
        setupSubviews()
        
        setupManufacturerModelLabelLayout()
        setupBodyConstantLabelLayout()
        setupBodyLabelLayout()
        setupYearOfIssueConstantLabelLayout()
        setupYearOfIssueLabel()
    }
    
    func setupSubviews() {
        contentView.addSubview(manufacturerModelLabel)
        contentView.addSubview(bodyConstantLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(yearOfIssueConstantLabel)
        contentView.addSubview(yearOfIssueLabel)
    }
    
    func setupManufacturerModelLabelLayout() {
        manufacturerModelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            manufacturerModelLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.verticalSpace
            ),
            manufacturerModelLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.horizontalSpace
            ),
            manufacturerModelLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.horizontalSpace
            ),
        ])
    }
    
    func setupBodyConstantLabelLayout() {
        bodyConstantLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyConstantLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            bodyConstantLabel.topAnchor.constraint(
                equalTo: manufacturerModelLabel.bottomAnchor,
                constant: Metrics.verticalSpace
            ),
            bodyConstantLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.horizontalSpace
            ),
        ])
    }
    
    func setupBodyLabelLayout() {
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(
                equalTo: manufacturerModelLabel.bottomAnchor,
                constant: Metrics.verticalSpace
            ),
            bodyLabel.leadingAnchor.constraint(
                equalTo: bodyConstantLabel.trailingAnchor,
                constant: Metrics.horizontalSpace / 2
            ),
            bodyLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.horizontalSpace
            ),
        ])
    }
    
    func setupYearOfIssueConstantLabelLayout() {
        yearOfIssueConstantLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yearOfIssueConstantLabel.topAnchor.constraint(
                equalTo: bodyConstantLabel.bottomAnchor,
                constant: Metrics.verticalSpace
            ),
            yearOfIssueConstantLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.verticalSpace
            ),
            yearOfIssueConstantLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.horizontalSpace
            ),
        ])
    }
    
    func setupYearOfIssueLabel() {
        yearOfIssueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yearOfIssueLabel.topAnchor.constraint(
                equalTo: bodyConstantLabel.bottomAnchor,
                constant: Metrics.verticalSpace
            ),
            yearOfIssueLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.verticalSpace
            ),
            yearOfIssueLabel.leadingAnchor.constraint(
                equalTo: yearOfIssueConstantLabel.trailingAnchor,
                constant: Metrics.horizontalSpace / 2
            ),
            yearOfIssueLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.horizontalSpace
            ),
        ])
    }
}
