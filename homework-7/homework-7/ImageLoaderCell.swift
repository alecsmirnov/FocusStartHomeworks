//
//  ImageLoaderCell.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

import UIKit

final class ImageLoaderCell: UITableViewCell {
    // MARK: Properties
       
    static let reuseIdentifier = String(describing: self)

    private enum Metrics {
        static let verticalSpace: CGFloat = 8
        static let horizontalSpace: CGFloat = 16
    }
    
    // MARK: Subviews
    
    private let mainImageView = UIImageView()
    
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

extension ImageLoaderCell {
    func configure(with image: UIImage) {
        mainImageView.image = image
    }
}

// MARK: - Appearance
private extension ImageLoaderCell {
    func setupAppearance() {
        setupMainImageViewAppearance()
    }
    
    func setupMainImageViewAppearance() {
        mainImageView.contentMode = .scaleAspectFit
    }
}

// MARK: - Layout
private extension ImageLoaderCell {
    func setupLayout() {
        setupSubviews()
        
        setupMainImageViewLayout()
    }
    
    func setupSubviews() {
        contentView.addSubview(mainImageView)
    }
    
    func setupMainImageViewLayout() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.verticalSpace),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.verticalSpace),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Metrics.horizontalSpace),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Metrics.horizontalSpace),
        ])
    }
}
