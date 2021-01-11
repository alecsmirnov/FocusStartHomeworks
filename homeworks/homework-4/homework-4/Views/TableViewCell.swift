//
//  TableViewCell.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

final class TableViewCell: UITableViewCell {
    // MARK: Properties
    
    static let reuseIdentifier = "TableViewCell"
    
    private enum Constants {
        static let horizontalSpace: CGFloat = 8
        static let verticalSpace: CGFloat = 8
        
        static let titleLabelSize: CGFloat = 20
    }
    
    // MARK: Subviews
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    
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

extension TableViewCell {
    func customize(record: Record) {
        titleLabel.text = record.title
        descriptionLabel.text = record.text
        dateLabel.text = TableViewCell.dateToString(date: record.date)
    }
}

// MARK: - Private Methods

private extension TableViewCell {
    static func dateToString(date: Date?) -> String? {
        guard let date = date else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
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
        titleLabel.font = .boldSystemFont(ofSize: Constants.titleLabelSize)
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
    func setupLayout() {
        setupSubviews()
        
        setupTitleLabelLayout()
        setupDescriptionLabelLayout()
        setupDateLabelLayout()
    }
    
    func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
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
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
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
        ])
    }
    
    func setupDateLabelLayout() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
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
        ])
    }
}
