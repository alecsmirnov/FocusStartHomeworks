//
//  TableViewCell.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

final class TableViewCell: UITableViewCell {
    // MARK: Properties
    
    static let identifier = "TableViewCell"
    
    private enum Constants {
        static let horizontalSpace: CGFloat = 8
        static let verticalSpace: CGFloat = 8
    }
    
    // MARK: Subviews
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    
    // MARK: Lifecycle
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAppearance()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension TableViewCell {
    func customize(title: String, description: String, date: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        dateLabel.text = date
    }
}

// MARK: - Appearance

private extension TableViewCell {
    func setupAppearance() {
        setupTitleLabelAppearance()
        setupDescriptionLabelAppearance()
        setupDateLabelAppearance()
    }
    
    func setupTitleLabelAppearance() {
        titleLabel.numberOfLines = 2
    }
    
    func setupDescriptionLabelAppearance() {
        descriptionLabel.numberOfLines = 2
    }
    
    func setupDateLabelAppearance() {
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .right
    }
}

// MARK: - Layout

private extension TableViewCell {
    func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
    }
    
    func setupLayout() {
        setupTitleLabelLayout()
        setupDescriptionLabelLayout()
        setupDateLabelLayout()
    }
    
    func setupTitleLabelLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalSpace),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.horizontalSpace
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.horizontalSpace
            ),
        ])
    }
    
    func setupDescriptionLabelLayout() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.verticalSpace),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.verticalSpace
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.horizontalSpace
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: dateLabel.leadingAnchor,
                constant: -Constants.horizontalSpace
            ),
            descriptionLabel.widthAnchor.constraint(
                lessThanOrEqualTo: contentView.widthAnchor,
                constant: -Constants.horizontalSpace
            ),
        ])
    }
    
    func setupDateLabelLayout() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(
                equalTo: descriptionLabel.trailingAnchor,
                constant: Constants.horizontalSpace
            ),
            dateLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.horizontalSpace
            ),
            dateLabel.widthAnchor.constraint(
                greaterThanOrEqualToConstant: descriptionLabel.frame.width
            ),
        ])
    }
}
