//
//  BodyCell.swift
//  homework-5
//
//  Created by Admin on 11.11.2020.
//

import UIKit

protocol BodyCellProtocol {
    var bodyToSelect: Body? { get set }    
    var checked: Bool { get set }
}

class BodyCell: UITableViewCell, BodyCellProtocol {
    // MARK: Properties
    
    var bodyToSelect: Body? {
        get { Body(rawValue: bodyLabel.text ?? "") }
        set { bodyLabel.text = newValue?.rawValue }
    }
    
    var checked = false {
        didSet {
            toggleCheckMark()
        }
    }
    
    static let reuseIdentifier = String(describing: self)
    
    private enum Metrics {
        static let horizontalSpace: CGFloat = 16
        static let verticalSpace: CGFloat = 8
    }
    
    // MARK: Subviews
    
    private let bodyLabel = UILabel()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension BodyCell {
    func toggleCheckMark() {
        if checked {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }
}

// MARK: - Layout

private extension BodyCell {
    func setupLayout() {
        contentView.addSubview(bodyLabel)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.verticalSpace
            ),
            bodyLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.verticalSpace
            ),
            bodyLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.horizontalSpace
            ),
            bodyLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.horizontalSpace
            ),
        ])
    }
}
